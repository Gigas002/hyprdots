#!/bin/bash

# default to ~/images
images_dir="${1:-$HOME/images}"
# default to 15 minutes
sleep_seconds="${2:-900}"

while true; do
    # take random file from directory
    img_path=$(find $images_dir -type f | shuf -n 1)
    swww img $img_path --transition-type grow --transition-fps 144 --transition-step 10
    sleep $sleep_seconds
done
