#!/bin/bash

setup_zoxide() {
  CURRENT_DIR="$(pwd)"
  TARGET_DIR="${XDG_DATA_HOME}/zoxide"
  TEMP_DIR="$(mktemp -d)"

  case "$(uname -s)" in
    Darwin)
      DOWNLOAD_URL="https://github.com/ajeetdsouza/zoxide/releases/download/v0.8.0/zoxide-v0.8.0-aarch64-apple-darwin.tar.gz"
      ;;
    Linux)
      DOWNLOAD_URL="https://github.com/ajeetdsouza/zoxide/releases/download/v0.8.0/zoxide-v0.8.0-x86_64-unknown-linux-musl.tar.gz"
      ;;
  esac

  cd "${TEMP_DIR}"

  mkdir -p "${TARGET_DIR}"

  if [ ! -f "${TARGET_DIR}/zoxide" ]; then
    wget -O zoxide.tar.gz "${DOWNLOAD_URL}"
    tar -C "${TARGET_DIR}" -xv -f zoxide.tar.gz
  fi

  mkdir -p "${HOME}/.local/bin"
  ln -sf "${TARGET_DIR}/zoxide" "${HOME}/.local/bin"

  cd "${CURRENT_DIR}"
}

