#!/bin/sh

set -e

cd "$(dirname "$0")/.."

link() {
    ln -sf "$(realpath $1)" "$2"
}

link ./git/gitconfig ~/.gitconfig
link ./git/gitconfig.local ~/.gitconfig.local
link ./zsh/.zshrc ~/.zshrc
link ./zsh/.zshenv ~/.zshenv

mkdir -p ~/.config/opencode
link ./opencode/opencode.jsonc ~/.config/opencode/opencode.jsonc
link ./opencode/tui.jsonc ~/.config/opencode/tui.jsonc
