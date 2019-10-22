# See this epic color codes guide: http://unix.stackexchange.com/a/124409/87343
PS1='\[\033[48;5;233;38;5;87m\]../\W\[\033[0m\] \[\033[33m\]`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\<\\\\\1\>\ /`\[\033[01;32m\]$\[\033[0m\] '

# Load environment variables.
source $HOME/dotfiles/.environment

# Load my aliases.
source $HOME/dotfiles/.aliases

# Misc bash functions.
source $HOME/dotfiles/.functions

# A little experiment: shortcuts for ssh'ing into various things
# The .ssh_hosts file will contain aliases that look like:
#
#   alias ssh_hostname="ssh user@hostname.example.com"
#
if [ -f ~/.ssh_hosts ]; then
    . ~/.ssh_hosts
fi

# Make sure our ssh keys actually work like they're supposed to :-/
# http://apple.stackexchange.com/a/254714/58762
# ssh-add -A 2>/dev/null;
