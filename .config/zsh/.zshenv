export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/sbin/"
export PATH="$PATH:/usr/local/smlnj/bin"
export PATH="$PATH:/usr/local/opt/llvm/bin"
export PATH="$PATH:/usr/local/opt/openjdk/bin"
export PATH="$PATH:/usr/local/opt/findutils/libexec/gnubin"
export PATH="$PATH:$HOME/Downloads"
export PATH="$PATH:$HOME/.emacs.d/bin"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/tmp/cc0/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.cabal/bin"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/code/tcmd"
export PATH="$PATH:$HOME/.npm-global-pkgs/bin"
export PATH="$PATH:$HOME/code/brutus"
export PATH="$PATH:$HOME/scripts"
export PATH="$PATH:$HOME/scripts/jukebox/"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.cabal/bin"
export PATH="$PATH:$HOME/.ghcup/bin"
export PATH="$PATH:$HOME/.local/share/nvim/site/pack/packer/start/vim-iced/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/util/flutter/bin"
export PATH="$PATH:/usr/local/Cellar/perl/5.34.0/bin/"

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

export EDITOR="nvim"
export PAGER="less -Ri"

# Have less display colours
# from: https://wiki.archlinux.org/index.php/Color_output_in_console#man
export LESS_TERMCAP_mb=$'\e[1;32m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;34m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;35m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;35m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal

export LS_COLORS="$(vivid generate ayu)"

export XDG_CONFIG_HOME="$HOME/.config"

java_thing() {
    export JAVA_HOME="/usr/local/opt/openjdk"
}

export FWMM_DIR="$HOME/.local/share/fwmm"
export NVM_DIR="$HOME/.nvm"

export PATSHOME="/usr/local/lib/ats2-postiats-0.4.2"

export DART_SDK="$HOME/util/flutter/bin/cache/dart-sdk"
export FLUTTER_HOME="$HOME/util/flutter"

export NNN_FIFO="/tmp/nnn.fifo"
export NNN_PLUG="p:preview-tui"

export FZF_DEFAULT_OPTS="--layout=reverse"

export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
export HOMEBREW_NO_AUTO_UPDATE=1

setopt HIST_IGNORE_SPACE
