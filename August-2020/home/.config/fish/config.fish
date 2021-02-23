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
alias code "code --force-device-scale-factor=1"
alias gitie "gitbatch -d $HOME/Code/Github"
alias mv "mv -iv"
alias cp "cp -riv"
alias mkdir "mkdir -vp"

# Homeshick default config
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

# for react-native
set -g -x ANDROID_HOME $HOME/Android/Sdk
set -g -x PATH $PATH:$ANDROID_HOME/emulator
set -g -x PATH $PATH:$ANDROID_HOME/tools
set -g -x PATH $PATH:$ANDROID_HOME/tools/bin
set -g -x PATH $PATH:$ANDROID_HOME/platform-tools

# Fish ssh-agent wrapper
fish_ssh_agent

# Micro 'xclip missing' error compensation
echo sometext | xclip
