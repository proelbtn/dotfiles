#!/bin/sh

set -e

cd "$(dirname "$0")/.."

background_image_url='https://kabekin.com/uploads/converted/24/05/02/673820730-summer_sea_cute_jk_20240502_pc_wallpaper_2560_kabekin-roXV-1829x1029-MM-100.jpg'
[ -f ./ghostty/background.jpg ] || curl -fL "$background_image_url" -o ./ghostty/background.jpg

copy() {
    [ -f "$2" ] || cp "$1" "$2"
}

link() {
    ln -sf "$(realpath $1)" "$2"
}

copy ./git/gitconfig.conf ~/.gitconfig
link ./git/gitconfig.common.conf ~/.gitconfig.common
copy ./git/gitconfig.local.conf ~/.gitconfig.local
link ./zsh/.zshrc ~/.zshrc
link ./zsh/.zshenv ~/.zshenv

mkdir -p ~/.config/opencode
link ./opencode/AGENTS.md ~/.config/opencode/AGENTS.md
link ./opencode/opencode.jsonc ~/.config/opencode/opencode.jsonc
link ./opencode/tui.jsonc ~/.config/opencode/tui.jsonc

mkdir -p ~/.config/herdr
link ./herdr/config.toml ~/.config/herdr/config.toml

mkdir -p ~/.config/ghostty
link ./ghostty/config ~/.config/ghostty/config
