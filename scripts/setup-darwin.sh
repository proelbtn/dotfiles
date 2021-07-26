#!/bin/bash

silent() {
  $@ >/dev/null 2>/dev/null
  return $?
}

expand() {
  local dir="$(cd "$(dirname "$1")"; pwd -P)"
  local base="$(basename "$1")"

  if [[ "$1" = "/" ]]; then
    echo "/"
  elif [[ "$dir" = "/" ]]; then
    echo "$dir$base"
  else
    echo "$dir/$base"
  fi
}

symlink() {
  local src=$(expand $1)
  local dst=$(expand $2)

  printf "[link] ${dst} -> ${src}\n"
  ln -sf "${src}" "${dst}"
}

cd $(dirname $0)/..


# zsh
symlink ./zsh/zshenv ~/.zshenv
symlink ./zsh/zshrc ~/.zshrc


# brew
silent which ipcalc || brew install ipcalc 
silent which hub || brew install hub
silent which nvim || brew install neovim
silent which tig || brew install tig
silent which wireshark || brew install --cask wireshark
