#!/bin/sh

cd "$(dirname "$0")/.."

link() {
    ln -sf "$(realpath $1)" "$2"
}

command_exists() {
    which "$1" >/dev/null 2>&1
}

command_exists fnm || brew install fnm
command_exists starship || brew install starship

link ./git/gitconfig ~/.gitconfig
link ./git/gitconfig.local ~/.gitconfig.local
link ./opencode/opencode.jsonc ~/.config/opencode/opencode.jsonc
link ./sheldon/plugins.toml ~/.config/sheldon/plugins.toml
link ./starship/starship.toml ~/.config/starship.toml
