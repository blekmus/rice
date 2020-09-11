#!/usr/bin/fish
# ███████╗██╗░██████╗██╗░░██╗
# ██╔════╝██║██╔════╝██║░░██║
# █████╗░░██║╚█████╗░███████║
# ██╔══╝░░██║░╚═══██╗██╔══██║
# ██║░░░░░██║██████╔╝██║░░██║
# ╚═╝░░░░░╚═╝╚═════╝░╚═╝░░╚═╝

# Remove default terminal greeting
set -U fish_greeting

# Remove file path underline
set fish_color_valid_path

# Aliases
alias la "ls -a"
alias code "code ~/Code/nominal-space.code-workspace"
alias gitie "gitbatch -d $HOME/Code/Github"

# Homeshick default config
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

# Fish ssh-agent wrapper
fish_ssh_agent

# Micro 'xclip missing' error compensation
echo sometext | xclip
