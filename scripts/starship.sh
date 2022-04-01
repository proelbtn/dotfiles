#!/bin/bash

setup_starship() {
  CURRENT_DIR="$(pwd)"
  TARGET_DIR="${XDG_DATA_HOME}/starship"
  TEMP_DIR="$(mktemp -d)"

  case "$(uname -s)" in
    Darwin)
      DOWNLOAD_URL="https://github.com/starship/starship/releases/download/v1.4.2/starship-aarch64-apple-darwin.tar.gz"
      ;;
    Linux)
      DOWNLOAD_URL="https://github.com/starship/starship/releases/download/v1.5.4/starship-x86_64-unknown-linux-musl.tar.gz"
      ;;
  esac

  cd "${TEMP_DIR}"

  mkdir -p "${TARGET_DIR}"

  if [ ! -f "${TARGET_DIR}/starship" ]; then
    wget -O starship.tar.gz "${DOWNLOAD_URL}"
    tar -C "${TARGET_DIR}" -xv -f starship.tar.gz
  fi
 
  mkdir -p "${HOME}/.local/bin"
  ln -sf "${TARGET_DIR}/starship" "${HOME}/.local/bin"

  cd "${CURRENT_DIR}"
}
