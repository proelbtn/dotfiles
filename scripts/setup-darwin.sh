#!/bin/sh

cd "$(dirname "$0")/.."

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

mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
link ./ghostty/config "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
