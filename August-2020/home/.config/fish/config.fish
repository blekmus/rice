#!/usr/bin/fish

set -U fish_greeting
set fish_color_valid_path

alias la "ls -a"
alias code "code ~/Code/nominal-space.code-workspace"
alias gitie "gitbatch -d $HOME/Code/Github"

source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

fish_ssh_agent
echo sometext | xclip


# Start X at login
# if status is-login
    # if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        # exec startx -- -keeptty
    # end
# end
# 
