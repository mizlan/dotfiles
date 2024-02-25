# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# python
# eval "$(pyenv init -)"

# perl
# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

# java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# haskell
[ -f "/Users/ml/.ghcup/env" ] && source "/Users/ml/.ghcup/env"

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
export PATH="$HOME/go/bin:$PATH"

# kitty
export KITTY_DEVELOP_FROM="$HOME/Repositories/kitty"

# zig
export PATH="$PATH:$HOME/.zvm/bin"

# kattis
export PATH="$PATH:$HOME/Repositories/kattis-cli"

# typst
export PATH="$PATH:$HOME/Repositories/typst-lsp/target/release"
