#!/bin/bash
#|---/ /+------------------------------------+---/ /|#
#|--/ /-| Script to restore personal configs |--/ /-|#
#|-/ /--| Prasanth Rangan                    |-/ /--|#
#|/ /---+------------------------------------+/ /---|#

source global_fn.sh
if [ $? -ne 0 ] ; then
    echo "Error: unable to source global_fn.sh, please execute from $(dirname "$(realpath "$0")")..."
    exit 1
fi

ThemeOverride="${1:-}"              #override default config list with custom theme list [param 1]
CfgDir="${2:-${CloneDir}/Configs}"  #override default config path with custom theme path [param 2]

if [ ! -f "${ThemeOverride}restore_cfg.lst" ] || [ ! -d "${CfgDir}" ] ; then
    echo "ERROR : '${ThemeOverride}restore_cfg.lst' or '${CfgDir}' does not exist..."
    exit 1
fi

cat "${ThemeOverride}restore_cfg.lst" | while read lst
do

    ovrWrte=`echo "${lst}" | awk -F '|' '{print $1}'`
    bkpFlag=`echo "${lst}" | awk -F '|' '{print $2}'`
    pth=`echo "${lst}" | awk -F '|' '{print $3}'`
    pth=`eval echo "${pth}"`
    cfg=`echo "${lst}" | awk -F '|' '{print $4}'`
    pkg=`echo "${lst}" | awk -F '|' '{print $5}'`

    while read -r pkg_chk
    do
        if ! pkg_installed ${pkg_chk}
            then
            echo "skipping ${pth}/${cfg} as dependency ${pkg_chk} is not installed..."
            continue 2
        fi
    done < <( echo "${pkg}" | xargs -n 1 )

    echo "${cfg}" | xargs -n 1 | while read -r cfg_chk
    do
        if [[ -z "${pth}" ]]; then continue; fi
        tgt=`echo "${pth}" | sed "s+^${HOME}++g"`

        if [ ! -d "${pth}" ] ; then
            mkdir -p "${pth}"
        fi

        if [ ! -f "${pth}/${cfg_chk}" ] ; then
            cp -r "${CfgDir}${tgt}/${cfg_chk}" "${pth}"
            echo "config restored ${pth} <-- ${CfgDir}${tgt}/${cfg_chk}..."
        elif [ "${ovrWrte}" == "Y" ] ; then
            cp -r "${CfgDir}$tgt/${cfg_chk}" "${pth}"
            echo "warning: config overwritten without backup ${pth} <-- ${CfgDir}${tgt}/${cfg_chk}..."
        else
            echo "Skipping ${pth}/${cfg_chk} to preserve user setting..."
        fi
    done

done
