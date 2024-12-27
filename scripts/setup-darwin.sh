#!/bin/zsh

cd "$(dirname $0)"
source ./common.sh

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

cd ..

# zsh
symlink ./zsh/env.zsh ~/.zshenv
symlink ./zsh/rc.zsh ~/.zshrc

mkdir -p ~/.config/sheldon
symlink ./sheldon/plugins.toml ~/.config/sheldon/plugins.toml

mkdir -p ~/.config
symlink ./starship/starship.toml ~/.config/starship.toml

# git
symlink ./git/gitconfig ~/.gitconfig
if [ ! -f ~/.gitconfig.local ]; then
  cp ./git/gitconfig.local ~/.gitconfig.local
fi
