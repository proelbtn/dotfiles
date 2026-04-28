#!/bin/sh

set -e

cd "$(dirname "$0")/.."

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
