#!/bin/sh

cd "$(dirname "$0")/.."

link() {
    ln -sf "$(realpath $1)" "$2"
}

command_exists() {
    which "$1" >/dev/null 2>&1
}

command_exists starship || brew install starship

link ./jj/config.toml ~/.config/jj/config.toml
link ./starship/starship.toml ~/.config/starship.toml
link ./zsh/.zshrc ~/.zshrc
link ./zsh/.zshenv ~/.zshenv
