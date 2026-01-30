# kiro pre-zsh hook.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh"

# ---------------------------------------
# Main zsh config
# ---------------------------------------

# If you come from bash you might have to change your $PATH.
export PATH=/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Dsable marking untracked files under VCS as dirty.
# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# ---------------------------------------
# zsh plugins
# ---------------------------------------

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tig poetry)

source $ZSH/oh-my-zsh.sh

# ---------------------------------------
# User configuration
# ---------------------------------------

# Include /opt/bin
export PATH=/opt/bin:$PATH

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
source $HOME/.aliases

# Source my custom environment variables.
source $HOME/.environments

# pull in my custome bash functions?
source $HOME/.functions

# Enable direnv: https://direnv.net/docs/hook.html
eval "$(direnv hook zsh)"

# Allow direnv to update the PS1 to show my active python virtualenv.
# https://github.com/direnv/direnv/wiki/Python#zsh
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
PS1='$(show_virtual_env)'$PS1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Created by `pipx` on 2024-09-05 21:11:14
export PATH="$PATH:$HOME/.local/bin"


# Enable aws_completer
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

# fnm: a node manager. See: https://github.com/Schniz/fnm
FNM_PATH="/home/brad/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# Add $HOME/bin to path if it exists
if [[ -d "${HOME}/bin" ]]; then
    export PATH=$HOME/bin:$PATH
fi

# Add snaps to the path
export PATH=$PATH:/snap/bin

# Set up bash completion
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

# ---------------------------------------
# AI assistant configuration
# ---------------------------------------

# Kiro CLI post block.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zshrc.post.zsh"

# opencode
if [[ -d "${HOME}/.opencode/bin" ]]; then
    export PATH=/home/brad/.opencode/bin:$PATH
fi
