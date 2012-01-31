# MySQL Junk
PATH=/usr/local/bin:/usr/local/mysql/bin:/usr/local/sbin:$PATH
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/

#PS1="\H:\w$ "
PS1="../\W $ "
# OpenCV libraries
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/sw/lib
#export PKG_CONFIG_PATH=$PKG_CONFIG_PAGH:/usr/local/lib/pkgconfig
#DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/lib:/sw/lib:/usr/lib
#export DYLD_LIBRARY_PATH
#export DYLD_FALLBACK_LIBRARY_PATH=/sw/lib:$DYLD_FALLBACK_LIBRARY_PATH

# create some environment variables for svn
export SVN_EDITOR=/usr/bin/vi
export VISUAL=/usr/bin/vi
export EDITOR=/usr/bin/vi

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
export PIP_REQUIRE_VIRTUALENV=true
export PIP_RESPECT_VIRTUALENV=true

# For cx-Oracle
export ORACLE_HOME=$HOME/Oracle10g_MacOSX/instantclient/instantclient_10_2
export ORACLE_SID=ODSP
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$ORACLE_HOME
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME

# GeoDjango Libraries
export PATH=/Library/Frameworks/UnixImageIO.framework/Programs:$PATH
export PATH=/Library/Frameworks/PROJ.framework/Programs:$PATH
export PATH=/Library/Frameworks/GEOS.framework/Programs:$PATH
export PATH=/Library/Frameworks/SQLite3.framework/Programs:$PATH
export PATH=/Library/Frameworks/GDAL.framework/Programs:$PATH
export PATH=/usr/local/pgsql/bin:$PATH

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

decrypt() 
{
    openssl des3 -d -salt -in $1 -out $2
}
encrypt()
{
    openssl des3 -salt -in $1 -out $2
}

# Git shortcuts
pull() 
{
    CURRENT=`git branch | grep '\*' | awk '{print $2}'`
    REMOTE=${CURRENT%-dev}

    echo "--- do you want to do this? ---"
    echo "git checkout ${REMOTE}"
    echo "git pull origin ${REMOTE}"
    echo "git checkout ${CURRENT}"
    echo "git rebase ${REMOTE}"
    echo "-------------------------------"
}
push()
{
    CURRENT=`git branch | grep '\*' | awk '{print $2}'`
    REMOTE=${CURRENT%-dev}

    echo "--- do you want to do this? ---"
    echo "git checkout ${REMOTE}"
    echo "git merge ${CURRENT}"
    echo "git push origin ${REMOTE}"
    echo "git checkout ${CURRENT}"
    echo "-------------------------------"
}

# Aliases
alias ls='ls -G'
alias ll='ls -lhG'
alias la='ls -ahG'
alias top=htop
alias get=git
alias knive=knife

# Nifty Python Aliases
alias email='python -m smtpd -n -c DebuggingServer localhost:1025'
alias serve='python -m SimpleHTTPServer'
alias rmpyc='find ./ -type f -name "*.pyc" -exec rm {} \;'
alias mp3player="find . -name '*.mp3' -exec afplay '{}' \;"

# Pure Awesome. (brew install sox to get the play command)
alias impulsepower="play -n -c1 synth whitenoise band -n 100 20 band -n 50 20 gain +25  fade h 1 864000 1"

# RVM and rvm bash completion
[[ -s "/Users/brad/.rvm/scripts/rvm" ]] && source "/Users/brad/.rvm/scripts/rvm"
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
# Add the current ruby to the prompt
RVM_INFO="\$($HOME/.rvm/bin/rvm-prompt i v p g)"
PS1="($RVM_INFO) $PS1"

# Opscode/Chef stuff
export OPSCODE_ORGNAME="coroutine"
export OPSCODE_USER="bkmontgomery"
# save me some typing when creating intances at rackspace
function kniferack
{
    if [ -z "$1" ] || [ -z "$2" ]; then 
        echo "USAGE: kniferack <hostname> \"<role/recipe list>\""
    else
        hostname=$1
        roles_and_recipes=$2
        echo 
        echo "Running Command:
        knife rackspace server create -N $hostname -S $hostname -x root -r \"$roles_and_recipes\" -I 112 -f 1"
        echo '--------------------------------------'
        knife rackspace server create -N $hostname -S $hostname -x root -r "$roles_and_recipes" -I 112 -f 1
    fi
}
