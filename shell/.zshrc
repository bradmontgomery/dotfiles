# kiro pre-zsh hook.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh"

# ---------------------------------------
# Main zsh config
# ---------------------------------------

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty.
# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Consolidate all PATH modifications for performance
export PATH="/usr/local/bin:/opt/bin:$HOME/.local/share/fnm:$HOME/bin:$HOME/.local/bin:/snap/bin:$PATH"

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

# Enable aws_completer
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

# fnm: a node manager. See: https://github.com/Schniz/fnm
FNM_PATH="/home/brad/.local/share/fnm"
if [[ -d "$FNM_PATH" ]]; then
    eval "$(fnm env)"
fi

# Set up Terraform completion
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
