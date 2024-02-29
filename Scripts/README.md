# Notes

restore_cfg -> copies the `Configs/` stuff
restore_fnt -> un-archives and copies the `Source/arcs` stuff
themepatcher -> prefer using directory as input instead of repo (clone it manually)

lst file's structure:
overwrite|backup|dest|input|required-by

## Packages

These arcs can (?) be replaced with packages:

### Fonts

I *think* that it should be sufficient to install `nerd-fonts` meta-package

Font_NotoSansCJK -> noto-fonts-cj
Font_MononokiNerd -> ttf-mononoki-nerd
Font_MaterialDesign -> ttf-material-design-icons-git
Font_MapleNerd -> ttf-maple
Font_JetBrainsMono -> ttf-jetbrains-mono-nerd
Font_CascadiaCove -> ttf-cascadia-code

### Cursors

Cursor_BibataIce -> bibata-cursor-theme

Added:

`xcursor-simp1e` package group
