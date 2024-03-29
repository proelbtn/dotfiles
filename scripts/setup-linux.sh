#!/bin/bash

cd "$(dirname $0)/.."

source ./scripts/common.sh
source ./scripts/starship.sh
source ./scripts/zoxide.sh

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
  local src="$(expand $1)"
  local dst="$(expand $2)"

  printf "[link] ${dst} -> ${src}\n"
  ln -sf "${src}" "${dst}"
}

# rust
[ ! -d "${HOME}/.cargo" ] && curl https://sh.rustup.rs -sSf | sh -s -- -y || true
. "${HOME}/.cargo/env"

# zsh
[ ! -d "${XDG_DATA_HOME}/zinit" ] \
  && git clone https://github.com/zdharma-continuum/zinit.git "${XDG_DATA_HOME}/zinit" \
  || true
symlink ./zsh/env.zsh ~/.zshenv
symlink ./zsh/rc.zsh ~/.zshrc

# bash
symlink ./bash/rc.sh ~/.bashrc

# git
symlink ./git/gitconfig ~/.gitconfig

# cargo
silent which delta || cargo install git-delta
silent which exa || cargo install exa
silent which bat || cargo install bat
silent which hexyl || cargo install hexyl
silent which fd || cargo install fd-find
silent which rg || cargo install ripgrep

setup_starship
setup_zoxide
