#!/usr/bin/zsh

export ZSH_ROOT="$(dirname $(readlink ~/.zshrc))"

# ==============================================================================

## nix shell
source "$ZSH_ROOT/nix.zsh"

# If zsh is not started from `nix develop`, enter default `nix develop` shell.
_check-nix-develop || enter-nix-noreturn default

alias reload="enter-nix-noreturn default"


# ==============================================================================

# zshaddhistory

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

typeset -U PATH
typeset -U FPATH

export HISTFILE=~/.zsh_history
export HISTSIZE=262144
export SAVEHIST=262144

export PATH="${PATH}:${ZSH_ROOT}/bin"
export FPATH="${FPATH}:${ZSH_ROOT}/functions"

export TERM="xterm-256color"

silent which nvim && export EDITOR="${EDITOR:-nvim}"
silent which vim && export EDITOR="${EDITOR:-vim}"
silent which vi && export EDITOR="${EDITOR:-vi}"

export PATH="${HOME}/.local/bin:${PATH}"

stty -ixon -ixoff

autoload -Uz compinit
autoload -Uz promptinit
autoload -Uz cdtemp

# ==============================================================================

# Options
# For more information: https://zsh.sourceforge.io/Doc/Release/Options.html

## 16.2.4 History
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

## 16.2.6 Input/Output
setopt correct
setopt interactive_comments
unsetopt rm_star_silent
setopt short_loops

## 16.2.7 Job Control
setopt check_jobs

## 16.2.8 Prompting
setopt prompt_cr
setopt prompt_sp

# ==============================================================================

compinit
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
# zstyle ':completion:*:messages' format '%d'
# zstyle ':completion:*:warning' format 'No matches for: %d'

zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:descriptions' format '%F{yellow}%B%d%b%f'
zstyle ':completion:*:corrections' format '%F{yellow}%B%d %{red}(errors: %e)%f%b'
zstyle ':completion:*:options' description yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 2 numeric
zstyle ':completion:*:functions' ignored-patterns '_*'


# aliases

silent which exa && alias ls="exa"
silent which bat && alias cat="bat"
silent which hexyl && alias od="hexyl"
silent which fd && alias find="fd"

alias ls="ls --color"


# alias python="uv run --python 3.13 python"
# alias python3="uv run --python 3.13 python3"
# alias pip="uv run --python 3.13 pip"
# alias pip3="uv run --python 3.13 pip3"


# bindkeys

bindkey -e
bindkey -r "^b"; bindkey "^b" backward-word
bindkey -r "^f"; bindkey "^f" forward-word
bindkey -r "^[[A"; bindkey "^[[A" up-line-or-search
bindkey -r "^[[B"; bindkey "^[[B" down-line-or-search

# binary packages

eval "$(sheldon source)"

source <(fzf --zsh)

# external script loading

load_script "${HOME}/.zshrc.local"
load_script "${ZSH_ROOT}/iterm2.zsh"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
