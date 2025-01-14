# add /usr/local/bin ourselves
export PATH="/usr/local/bin:$PATH"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# python
# eval "$(pyenv init -)"

# java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# haskell
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# ocaml
source "$HOME/.opam/opam-init/init.zsh" >/dev/null 2>/dev/null

# lean
export PATH="$HOME/.elan/bin:$PATH"

# npm
export PATH="$HOME/npm-global/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Lang/pnpm"
export PATH="$PNPM_HOME:$PATH"

# rust
. "$HOME/.cargo/env"

# local
export PATH="$HOME/.local/bin:$PATH"

# go
export PATH="$HOME/Lang/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# # kitty
# export KITTY_DEVELOP_FROM="$HOME/Repositories/kitty"

# zig
export PATH="$PATH:$HOME/.zvm/bin"

# kattis
export PATH="$PATH:$HOME/Repositories/kattis-cli"

# typst
export PATH="$PATH:$HOME/Repositories/typst-lsp/target/release"

# latex
export PATH="/Library/TeX/texbin:$PATH"

# /etc/paths messes with our PATH
export PATH_SAVE=$PATH
