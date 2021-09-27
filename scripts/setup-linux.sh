#!/bin/bash

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:-/etc/xdg}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

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
[ ! -d "${XDG_DATA_HOME}/zinit" ] \
  && git clone https://github.com/zdharma/zinit.git "${XDG_DATA_HOME}/zinit" \
  || true
symlink ./zsh/env.zsh ~/.zshenv
symlink ./zsh/rc.zsh ~/.zshrc


# git
symlink ./git/gitconfig ~/.gitconfig


# rust
[ ! -d "${HOME}/.cargo" ] && curl https://sh.rustup.rs -sSf | sh -s -- -y || true
. "${HOME}/.cargo/env"

# cargo
silent which delta || cargo install git-delta
silent which exa || cargo install exa
silent which bat || cargo install bat
silent which hexyl || cargo install hexyl
silent which fd || cargo install fd
silent which rg || cargo install ripgrep
