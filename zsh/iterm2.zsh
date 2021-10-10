# This script based on iterm2_shell_integration.zsh

if [[ -o interactive ]]; then
  if [ "${ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX-}""$TERM" != "screen" -a "${ITERM_SHELL_INTEGRATION_INSTALLED-}" = "" -a "$TERM" != linux -a "$TERM" != dumb ]; then
    ITERM_SHELL_INTEGRATION_INSTALLED=Yes

    iterm2_set_user_var() {
      printf "\033]1337;SetUserVar=%s=%s\007" "$1" $(printf "%s" "$2" | base64 | tr -d '\n')
    }

    iterm2_print_state_data() {
      local _iterm2_hostname="${iterm2_hostname-}"
      if [ -z "${iterm2_hostname:-}" ]; then
        _iterm2_hostname=$(hostname -f 2>/dev/null)
      fi
      printf "\033]1337;RemoteHost=%s@%s\007" "$USER" "${_iterm2_hostname-}"
      printf "\033]1337;CurrentDir=%s\007" "$PWD"
      
      iterm2_set_user_var platform "$(uname -m)/$(uname -s)/$(uname -r)"
      it2git
    }

    iterm2_precmd() {
      iterm2_print_state_data
    }

    if [ -z "${iterm2_hostname-}" ]; then
      if [ "$(uname)" != "Darwin" ]; then
        iterm2_hostname=`hostname -f 2>/dev/null`
        # Some flavors of BSD (i.e. NetBSD and OpenBSD) don't have the -f option.
        if [ $? -ne 0 ]; then
          iterm2_hostname=`hostname`
        fi
      fi
    fi

    iterm2_print_state_data
    printf "\033]1337;ShellIntegrationVersion=12;shell=zsh\007"

    [[ -z ${precmd_functions-} ]] && precmd_functions=()
    precmd_functions=($precmd_functions iterm2_precmd)
  fi
fi
