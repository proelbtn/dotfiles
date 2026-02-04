eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -f ~/.zshenv.local ]; then
    source ~/.zshenv.local
fi
