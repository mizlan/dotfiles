source (pyenv init -|psub)
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color --bold red
      echo '[N]'
    case insert
      set_color --bold yellow
      echo '[I]'
    case replace_one
      set_color --bold yellow
      echo '[R]'
    case visual
      set_color --bold brmagenta
      echo '[V]'
    case '*'
      set_color --bold red
      echo '[?]'
  end
  set_color normal
  echo ' '
end

set -x LESS_TERMCAP_mb (set_color -o magenta)
set -x LESS_TERMCAP_md (set_color -o $fish_color_param)
set -x LESS_TERMCAP_so (set_color -r yellow)
set -x LESS_TERMCAP_us (set_color -u $fish_color_cwd)
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x GROFF_NO_SGR yes

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
test -f /Users/michaellan/.ghcup/env ; and set -Ua fish_user_paths $HOME/.cabal/bin /Users/michaellan/.ghcup/bin
