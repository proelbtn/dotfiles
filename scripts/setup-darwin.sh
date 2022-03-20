#!/bin/bash

cd "$(dirname $0)"
source ./common.sh
source ./zoxide.sh

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

# starship
mkdir -p ~/.config
symlink ./starship/starship.toml ~/.config/starship.toml
silent which starship || brew install starship

# zsh
[ ! -d "${XDG_DATA_HOME}/zinit" ] && git clone https://github.com/zdharma-continuum/zinit.git "${XDG_DATA_HOME}/zinit" || true
symlink ./zsh/env.zsh ~/.zshenv
symlink ./zsh/rc.zsh ~/.zshrc


# rust
[ ! -d "${HOME}/.cargo" ] && curl https://sh.rustup.rs -sSf | sh -s -- -y || true
. "${HOME}/.cargo/env"


# brew
silent which asciinema || brew install asciinema
silent which ipcalc || brew install ipcalc 
silent which hub || brew install hub
silent which mtr || brew install mtr
silent which nmap || brew install nmap
silent which nvim || brew install neovim
silent which tig || brew install tig
silent which terminal-notifier || brew install terminal-notifier
silent which wireshark || brew install --cask wireshark


# cargo
silent which delta || cargo install git-delta
silent which exa || cargo install exa
silent which bat || cargo install bat
silent which hexyl || cargo install hexyl
silent which fd || cargo install fd
silent which rg || cargo install ripgrep

setup_zoxide
