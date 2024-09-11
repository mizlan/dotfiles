# interactive configuration

bindkey -e

alias e=nvim
alias n="/Applications/Neovide.app/Contents/MacOS/neovide"
alias t="$HOME/themechange.sh"
alias ls="gls --hyperlink=always --color=auto"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS "'--prompt="  "'' --pointer=" "'' --marker=·'

# rose-pine dawn/moon colors
fzf() {
  if grep -q dark "$HOME/theme"; then
    FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=fg:#e0def4,bg:#2a273f,hl:#6e6a86 --color=fg+:#908caa,bg+:#232136,hl+:#908caa --color=info:#9ccfd8,prompt:#f6c177,pointer:#c4a7e7 --color=marker:#ea9a97,spinner:#eb6f92,header:#ea9a97" /opt/homebrew/bin/fzf "$@"
    # FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=fg:#d8caac,bg:#323d43,hl:#83b6af --color=fg+:#d8caac,bg+:#2b3338,hl+:#83b6af --color=info:#d9bb80,prompt:#e68183,pointer:#d39bb6 --color=marker:#a7c080,spinner:#d39bb6,header:#87c095" /opt/homebrew/bin/fzf
  else
    FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=fg:#575279,bg:#fffaf3,hl:#9893a5 --color=fg+:#797593,bg+:#faf4ed,hl+:#797593 --color=info:#56949f,prompt:#56949f,pointer:#907aa9 --color=marker:#d7827e,spinner:#b4637a,header:#d7827e" /opt/homebrew/bin/fzf "$@"
  fi
}

# layout options
# export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height 40% --layout=reverse"

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

export WORDCHARS=''

export EDITOR="nvim"
export PAGER="less -Ri"

export LESS_TERMCAP_mb=$'\e[1;32m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;34m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;35m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;35m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' menu yes select

if type brew &>/dev/null
then
  fpath+=("$(brew --prefix)/share/zsh/site-functions")
fi

# cache the generation of completions
autoload -Uz compinit
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

source "$HOME/Repositories/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

ucla-wifi() {
  # wget --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 $1
  aria2c -x 16 -s 16 $1
}

sync-cs() {
  unison \
    -servercmd bin/unison-wrapper \
    -auto \
    -fastcheck true \
    -path notes/132 \
    -ignore 'Name .git' \
    -ignore 'Name venv' \
    -ignore 'Name __pycache__' \
   default $HOME ssh://michaell@lnxsrv07.seas.ucla.edu/D
}

e-ssh() {
  nvim oil-ssh://michaell@cs33.seas.ucla.edu/
}

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

export HISTSIZE=9999999999
export SAVEHIST=$HISTSIZE
HISTORY_IGNORE="(ls|cd|fg)"
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt SHARE_HISTORY

export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1

alias bal='yabai -m space --balance'

if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="no-cursor"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

export TLDR_AUTO_UPDATE_DISABLED=1

eval "$(zoxide init zsh)"

export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)"

eval "$(atuin init zsh)"

export PROMPT='$ '
