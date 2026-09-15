#!/bin/sh

cd "$(dirname "$0")/.."

background_image_url='https://kabekin.com/uploads/converted/24/05/02/673820730-summer_sea_cute_jk_20240502_pc_wallpaper_2560_kabekin-roXV-1829x1029-MM-100.jpg'
if [ ! -f ./ghostty/background.jpg ]; then
    curl -fL "$background_image_url" -o ./ghostty/background.jpg || exit 1
fi

copy() {
    [ -f "$2" ] || cp "$1" "$2"
}

link() {
    ln -sf "$(realpath $1)" "$2"
}

command_exists() {
    which "$1" >/dev/null 2>&1
}

command_exists fnm || brew install fnm
command_exists starship || brew install starship

copy ./git/gitconfig.conf ~/.gitconfig
link ./git/gitconfig.common.conf ~/.gitconfig.common
copy ./git/gitconfig.local.conf ~/.gitconfig.local
link ./opencode/opencode.jsonc ~/.config/opencode/opencode.jsonc
link ./starship/starship.toml ~/.config/starship.toml

mkdir -p ~/.config/herdr
link ./herdr/config.toml ~/.config/herdr/config.toml

mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
link ./ghostty/config "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
