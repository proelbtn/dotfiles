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
[ ! -d "~/.config/zinit" ] && git clone https://github.com/zdharma/zinit.git ~/.config/zinit || true
symlink ./zsh/zshenv ~/.zshenv
symlink ./zsh/zshrc ~/.zshrc

