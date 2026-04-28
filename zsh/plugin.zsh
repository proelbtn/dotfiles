# Plugin management (no external dependencies)
# Each plugin is cloned individually if missing, then loaded.

ensure_plugin() {
  local name="$1"
  local url="$2"
  local dir="${ZSH_ROOT}/plugins/${name}"

  if [[ ! -d "$dir" ]]; then
    echo "Cloning ${name}..."
    git clone --depth 1 "$url" "$dir"
  fi

  local init_file="${dir}/${name}.plugin.zsh"
  [[ -f "$init_file" ]] || init_file="${dir}/${name}.zsh"
  [[ -f "$init_file" ]] && source "$init_file"
}

update_plugins() {
  local plugin_dir="${ZSH_ROOT}/plugins"
  local dir
  for dir in "$plugin_dir"/*/.git(N); do
    dir="${dir%/.git}"
    echo "Updating ${dir:t}..."
    git -C "$dir" pull --ff-only
  done
}

# ==============================================================================

# Load plugins (zsh-syntax-highlighting must be last)
ensure_plugin "zsh-completions" "https://github.com/zsh-users/zsh-completions.git"
ensure_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions.git"
ensure_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"
