# ------------------------------------------------------------------------------
# BASH config
#
# This file sets up a bash config; It kinda assumes MacOS, but could probably be
# used under linux as well. See the following:
#
# - .aliases: include custom aliases.
# - .autoenv: sets up autoenv if it's installed.
# - .environments: sets up a handful of custom environment variables.
# - .functions: define some random utillity functions
#
# USAGE: symlink to this file from your home directory.
# ------------------------------------------------------------------------------

# See this epic color codes guide: http://unix.stackexchange.com/a/124409/87343
PS1='\[\033[48;5;233;38;5;87m\]../\W\[\033[0m\] \[\033[33m\]`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\<\\\\\1\>\ /`\[\033[01;32m\]$\[\033[0m\] '

# Load environment variables.
source $HOME/dotfiles/.environments

# Load my aliases.
source $HOME/dotfiles/.aliases

# Misc bash functions.
source $HOME/dotfiles/.functions

# Keep using autoenv for bash (for now)
source $HOME/dotfiles/.autoenv

# Make sure our ssh keys actually work like they're supposed to :-/
# http://apple.stackexchange.com/a/254714/58762
# ssh-add -A 2>/dev/null;
