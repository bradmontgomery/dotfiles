# DEPRECATED: This file is for legacy bash/sh shells only.
#
# Modern zsh users should use ~/.zshrc and related files instead.
# This file is kept for compatibility with non-zsh login shells.
#
# If you're using zsh (the default), most of this configuration is duplicated
# in ~/.zshrc and related files.
#
# Original BASH config
# This file sets up a bash config; It kinda assumes MacOS, but could probably be
# used under linux as well. See the following:
#
# - .aliases: include custom aliases.
# - .environments: sets up a handful of custom environment variables.
# - .functions: define some random utility functions
#
# USAGE: symlink to this file from your home directory (for bash compatibility).
# See: https://github.com/bradmontgomery/dotfiles

# See this epic color codes guide: http://unix.stackexchange.com/a/124409/87343
PS1='\[\033[48;5;233;38;5;87m\]../\W\[\033[0m\] \[\033[33m\]`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\<\\\\\1\>\ /`\[\033[01;32m\]$\[\033[0m\] '

# Load environment variables.
source "$HOME/.environments"

# Load my aliases.
source "$HOME/.aliases"

# Misc bash functions.
source "$HOME/.functions"

