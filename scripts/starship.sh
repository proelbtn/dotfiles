#!/bin/bash

DOWNLOAD_URL_DARWIN_ARM64="https://github.com/starship/starship/releases/download/v1.4.2/starship-aarch64-apple-darwin.tar.gz"
DOWNLOAD_URL_LINUX_X86_64="https://github.com/starship/starship/releases/download/v1.4.2/starship-x86_64-unknown-linux-gnu.tar.gz"

setup_starship_Darwin_arm64() {
  if [ -d "${XDG_DATA_HOME}/starship" ]; then
    cd "${XDG_DATA_HOME}/starship"
  else
    mkdir -p "${XDG_DATA_HOME}/starship"
    cd "${XDG_DATA_HOME}/starship"

    wget -O starship.tar.gz "${DOWNLOAD_URL_DARWIN_ARM64}"
    tar xfv starship.tar.gz

    rm -rf starship.tar.gz
  fi

  ln -sf "$(pwd)/starship" "${HOME}/.local/bin"

}

setup_starship_Linux_x86_64() {
  if [ -d "${XDG_DATA_HOME}/starship" ]; then
    cd "${XDG_DATA_HOME}/starship"
  else
    mkdir -p "${XDG_DATA_HOME}/starship"
    cd "${XDG_DATA_HOME}/starship"

    wget -O starship.tar.gz "${DOWNLOAD_URL_DARWIN_X86_64}"
    tar xfv starship.tar.gz

    rm -rf starship.tar.gz
  fi

  ln -sf "$(pwd)/starship" "${HOME}/.local/bin"
}

setup_starship() {
  "setup_starship_$(uname -s)_$(uname -m)"
}

