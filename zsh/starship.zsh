# Starship prompt (no brew dependency)
# Downloads binary from GitHub Releases if missing

STARSHIP_BIN="${HOME}/.local/bin/starship"
STARSHIP_VERSION="${STARSHIP_VERSION:-latest}"

ensure_starship() {
  [[ -x "$STARSHIP_BIN" ]] && return 0

  local version="$STARSHIP_VERSION"
  if [[ "$version" == "latest" ]]; then
    version=$(curl -fsSL https://api.github.com/repos/starship/starship/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    if [[ -z "$version" ]]; then
      echo "Failed to fetch latest starship version" >&2
      return 1
    fi
  fi

  local arch
  case "$(uname -m)" in
    x86_64) arch="x86_64" ;;
    aarch64|arm64) arch="aarch64" ;;
    *)
      echo "Unsupported architecture: $(uname -m)" >&2
      return 1
      ;;
  esac

  local target
  case "$(uname -s)" in
    Linux*)
      if [[ "$arch" == "aarch64" ]]; then
        target="aarch64-unknown-linux-musl"
      else
        target="x86_64-unknown-linux-gnu"
      fi
      ;;
    Darwin*)
      target="${arch}-apple-darwin"
      ;;
    *)
      echo "Unsupported OS: $(uname -s)" >&2
      return 1
      ;;
  esac

  local tarball="starship-${target}.tar.gz"
  local url="https://github.com/starship/starship/releases/download/${version}/${tarball}"
  mkdir -p "${HOME}/.local/bin"

  local tmpdir
  tmpdir=$(mktemp -d)
  trap 'rm -rf "$tmpdir"' EXIT

  echo "Downloading starship ${version} (${arch}-${os})..."
  if ! curl -fsSL "$url" -o "${tmpdir}/${tarball}"; then
    echo "Failed to download starship from ${url}" >&2
    return 1
  fi

  tar -xzf "${tmpdir}/${tarball}" -C "${HOME}/.local/bin"
  chmod +x "$STARSHIP_BIN"

  echo "Installed starship to ${STARSHIP_BIN}"
}

ensure_starship || return

export STARSHIP_CONFIG
STARSHIP_CONFIG="$(realpath "${ZSH_ROOT}/../starship/starship.toml")"

eval "$($STARSHIP_BIN init zsh)"
