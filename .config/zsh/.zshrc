#
# .zshrc
#

# Have less display colours
# from: https://wiki.archlinux.org/index.php/Color_output_in_console#man
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# load-opam() {
#   test -r /Users/michaellan/.opam/opam-init/init.zsh && . /Users/michaellan/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
# }

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu yes select

bindkey -v
bindkey '^R' history-incremental-search-backward

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(pyenv init - --no-rehash)"

alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

save() { tee $HOME/.save-output }
pull() { cat $HOME/.save-output }

source $ZDOTDIR/zsh_prompt
