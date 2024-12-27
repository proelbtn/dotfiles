## Rust

Rustの開発環境を構築するには、[rustup](https://www.rust-lang.org/ja/tools/install)を利用することができます。

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo '. "$HOME/.cargo/env"' >> ~/.zshrc.local
```

##

```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

ref: https://zenn.dev/asa1984/books/nix-hands-on


```
nix develop ~/.dotfiles --command zsh
```

* https://search.nixos.org/packages


##

```
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.dotfiles/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
```
