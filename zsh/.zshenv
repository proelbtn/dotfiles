export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# eval "$(/opt/homebrew/bin/brew shellenv)"

export GOPATH="$XDG_DATA_HOME/go"
export PATH="$GOPATH/bin:$PATH"

if [ -f ~/.zshenv.local ]; then
    source ~/.zshenv.local
fi

if [ -f ~/.config/opencode/opencode.local.jsonc ]; then
    export OPENCODE_CONFIG="$HOME/.config/opencode/opencode.local.jsonc"
fi

export OPENCODE_DISABLE_CLAUDE_CODE="1"
export OPENCODE_ENABLE_EXA="1"
