#!/usr/bin/zsh

# ==============================================================================

silent() {
  $@ >/dev/null 2>/dev/null
  return $?
}

load_script() {
  local script=$1
  if [ -f "$script" ]; then
    source "$script"
  fi
}

# ==============================================================================

export BASH_ROOT="$(dirname $(readlink ~/.bashrc))"

export PATH="${PATH}:${BASH_ROOT}/bin"

export TERM="xterm-256color"

silent which nvim && export EDITOR="${EDITOR:-nvim}"
silent which vim && export EDITOR="${EDITOR:-vim}"
silent which vi && export EDITOR="${EDITOR:-vi}"

export PATH="${HOME}/.local/bin:${PATH}"

stty -ixon -ixoff

# ==============================================================================

# aliases

alias reload="exec bash"

case "$(uname -s)" in
  Darwin)
    alias ls="ls -G"
    ;;
  Linux)
    alias ls="ls --color"
    ;;
esac

# external script loading

load_script "${HOME}/.bashrc.local"

eval "$(starship init bash)"
eval "$(zoxide init bash)"
