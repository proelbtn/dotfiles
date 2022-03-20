#!/bin/bash

DOWNLOAD_URL_DARWIN_ARM64="https://github.com/ajeetdsouza/zoxide/releases/download/v0.8.0/zoxide-v0.8.0-aarch64-apple-darwin.tar.gz"
DOWNLOAD_URL_LINUX_X86_64="https://github.com/ajeetdsouza/zoxide/releases/download/v0.8.0/zoxide-v0.8.0-x86_64-unknown-linux-musl.tar.gz"

setup_zoxide_Darwin_arm64() {
  if [ -d "${XDG_DATA_HOME}/zoxide" ]; then
    cd "${XDG_DATA_HOME}/zoxide"
  else
    mkdir -p "${XDG_DATA_HOME}/zoxide"
    cd "${XDG_DATA_HOME}/zoxide"

    wget -O zoxide.tar.gz "${DOWNLOAD_URL_DARWIN_ARM64}"
    tar xfv zoxide.tar.gz

    rm -rf zoxide.tar.gz
  fi

  ln -sf "$(pwd)/zoxide" "${HOME}/.local/bin"

}

setup_zoxide_Linux_x86_64() {
  if [ -d "${XDG_DATA_HOME}/zoxide" ]; then
    cd "${XDG_DATA_HOME}/zoxide"
  else
    mkdir -p "${XDG_DATA_HOME}/zoxide"
    cd "${XDG_DATA_HOME}/zoxide"

    wget -O zoxide.tar.gz "${DOWNLOAD_URL_DARWIN_ARM64}"
    tar xfv zoxide.tar.gz

    rm -rf zoxide.tar.gz
  fi

  ln -sf "$(pwd)/zoxide" "${HOME}/.local/bin"
}

setup_zoxide() {
  "setup_zoxide_$(uname -s)_$(uname -m)"
}

