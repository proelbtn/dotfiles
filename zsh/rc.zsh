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

typeset -U PATH
typeset -U FPATH

export ZSH_ROOT="$(dirname $(readlink ~/.zshrc))"

export HISTFILE=~/.zsh_history
export HISTSIZE=262144
export SAVEHIST=262144

export PATH="${PATH}:${ZSH_ROOT}/bin"
export FPATH="${FPATH}:${ZSH_ROOT}/functions"

export TERM="xterm-256color"

silent which nvim && export EDITOR="${EDITOR:-nvim}"
silent which vim && export EDITOR="${EDITOR:-vim}"
silent which vi && export EDITOR="${EDITOR:-vi}"

load_script "${XDG_DATA_HOME}/zinit/zinit.zsh"

zinit light mafredri/zsh-async
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma/fast-syntax-highlighting

stty -ixon -ixoff

autoload -Uz compinit
autoload -Uz promptinit
autoload -Uz cdtemp

eval "$(starship init zsh)"

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

alias reload="exec zsh"
alias -g foreach="xargs -I {}"
silent which exa && alias ls="exa"
silent which bat && alias cat="bat"
silent which hexyl && alias od="hexyl"
silent which fd && alias find="fd"

case "$(uname -s)" in
  Darwin)
    alias ls="ls -G"
    ;;
  Linux)
    alias ls="ls --color"
    ;;
esac


# bindkeys

bindkey -e
bindkey -r "^b"; bindkey "^b" backward-word
bindkey -r "^f"; bindkey "^f" forward-word
bindkey -r "^[[A"; bindkey "^[[A" up-line-or-search
bindkey -r "^[[B"; bindkey "^[[B" down-line-or-search

# binary packages

zinit ice as:"program" from:"gh-r" ver:"0.27.2" pick:"fzf"
zinit light junegunn/fzf

case "$(uname -s)" in
  Darwin)
    zinit ice as:"program" from:"gh-r" ver:"jq-1.6" cp:"jq-osx-amd64 -> jq" pick:"jq"
    zinit light stedolan/jq
    ;;
  Linux)
    zinit ice as:"program" from:"gh-r" ver:"jq-1.6" cp:"jq-linux64 -> jq" pick:"jq"
    zinit light stedolan/jq
    ;;
esac


# external script loading

load_script "${HOME}/.zshrc.local"
load_script "${ZSH_ROOT}/iterm2.zsh"

if which zprof >/dev/null 2>/dev/null; then
  zprof
fi
