#PS1="\H:\w$ "
PS1='../\W `git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\<\\\\\1\>\ /`$ '

# NOT SURE WHY THIS BREAKS SHIT
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:/usr/local/share/python:$PYTHONPATH
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:/usr/local/share/python

# Node stuff
export NODE_PATH="/usr/local/lib/node_modules"

# Prefer /usr/local/bin over /usr/bin
export PATH="/usr/local/bin:$PATH"

# Prefer Postgres.app over everything else.
#export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

# Make Haskell's stuff available
export PATH="$HOME/Library/Haskell/bin:$PATH"

# Go
export PATH="$PATH:/usr/local/opt/go/libexec/bin"
#export GOROOT="/usr/local/opt/go/libexec/bin"

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
export PIP_REQUIRE_VIRTUALENV=true
export PIP_RESPECT_VIRTUALENV=true
source /usr/local/bin/virtualenvwrapper.sh

# For cx-Oracle
#export ORACLE_HOME=$HOME/Oracle10g_MacOSX/instantclient/instantclient_10_2
#export ORACLE_SID=ODSP
#export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$ORACLE_HOME
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME

# GeoDjango Libraries
#GEOS_LIBRARY_PATH='/Library/Frameworks/GEOS.framework/GEOS'
#GDAL_LIBRARY_PATH='/Library/Frameworks/GDAL.framework/GDAL'
#GEOIP_LIBRARY_PATH='/usr/local/Cellar/geoip/1.5.1/lib/libGeoIP.dylib'
#export PATH=/Library/Frameworks/UnixImageIO.framework/Programs:$PATH
#export PATH=/Library/Frameworks/PROJ.framework/Programs:$PATH
#export PATH=/Library/Frameworks/GEOS.framework/Programs:$PATH
#export PATH=/Library/Frameworks/SQLite3.framework/Programs:$PATH
#export PATH=/Library/Frameworks/GDAL.framework/Programs:$PATH
#export PATH=/usr/local/pgsql/bin:$PATH

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
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "USAGE: decrypt <input> <output>"
    else
        openssl des3 -d -salt -in $1 -out $2
    fi
}
encrypt()
{
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "USAGE: decrypt <input> <output>"
    else
        openssl des3 -salt -in $1 -out $2
    fi
}

function convert_to_mp3
{
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "USAGE: convert_to_mp3 <input_file> <output_file.mp3>"
    else
        ffmpeg -i $1 -acodec mp3 $2
    fi
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

function pyg()
{
    if [ -z "$1" ]; then
        echo "USAGE: pyg <input>"
    else
        echo "Running: pygmentize -f rtf $1 | pbcopy"
        pygmentize -f rtf $1 | pbcopy
    fi
}

# Aliases
alias ls='ls -G'
alias ll='ls -lhG'
alias la='ls -ahG'
alias hig='history | grep --color'
alias top=htop
alias get=git
alias knive=knife
alias VAGRANTDESTROY='vagrant destroy'
alias clera=clear

# Nifty Python Aliases
alias nosetests="nosetests --with-yanc"
alias email='python -m smtpd -n -c DebuggingServer localhost:1025'
alias serve='python -m SimpleHTTPServer'
alias rmpyc='find ./ -type f -name "*.pyc" -exec rm {} \;'
alias mp3player="find . -name '*.mp3' -exec afplay '{}' \;"
alias m4aplayer="find . -name '*.m4a' -exec afplay '{}' \;"
alias ipython_console="ipython qtconsole --pylab=inline"
alias lolutc='python -c "for h in range(0,24): print \"{0} utc --- {1} cdt --- {2} pdt\".format(h, (h-5)%24, (h-8)%24)"'
#alias lolutc='python -c "for h in range(0,24): print \"{0} utc --- {1} cst --- {2} pst\".format(h, (h-6)%24, (h-8)%24)"'
alias 936='python -m ninethreesix.password'

# A Function to list all the python classes in a file
function listclasses()
{
    if [ -z "$1" ]; then
        F="models.py"
    else
        F="$1"
    fi
    cat $F | grep "^class " | sed "s/class //" | sed "s/(.*$//" | sort
}
alias listmodels=listclasses | grep -v Manager

# Pure Awesome. (brew install sox to get the play command)
alias impulsepower="play -n -c1 synth whitenoise band -n 100 20 band -n 50 20 gain +25  fade h 1 864000 1"

# Alias for Love2d
alias love="/Applications/love.app/Contents/MacOS/love"

# A little function to zip up the current directory contents into a .love file.
function loveit()
{
    if [ -z "$1" ]; then
        echo "USAGE: loveit <name>"
    else
        zip -9 -q -r $1.love .
    fi
}

# A little experiment: shortcuts for ssh'ing into various things
# The .ssh_hosts file will contain aliases that look like:
#
#   alias ssh_hostname="ssh user@hostname.example.com"
#
if [ -f ~/.ssh_hosts ]; then
    . ~/.ssh_hosts
fi

# sigh. put my homebrew ruby bin on the path
#export PATH="$PATH:/usr/local/Cellar/ruby/1.9.3-p0/bin"

# rbenv
#eval "$(rbenv init -)"

# Opscode/Chef stuff
export OPSCODE_ORGNAME="workforpie"
export OPSCODE_USER="workforpie"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Load the secret env vars.
source $HOME/Dropbox/dotfiles/secrets.sh
