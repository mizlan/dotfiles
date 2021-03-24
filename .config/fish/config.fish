source (pyenv init -|psub)
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# function fish_mode_prompt
#   switch $fish_bind_mode
#     case default
#       echo 'N '
#     case insert
#       echo 'I '
#     case replace_one
#       echo 'R '
#     case visual
#       echo 'V  '
#     case '*'
#       echo '? '
#   end
# end

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

# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
test -f /Users/michaellan/.ghcup/env ; and set -gx fish_user_paths $HOME/.cabal/bin /Users/michaellan/.ghcup/bin $fish_user_paths
