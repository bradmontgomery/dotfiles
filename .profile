# See this epic color codes guide: http://unix.stackexchange.com/a/124409/87343
PS1='\[\033[48;5;233;38;5;87m\]../\W\[\033[0m\] \[\033[33m\]`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\<\\\\\1\>\ /`\[\033[01;32m\]$\[\033[0m\] '

# Node stuff
export NODE_PATH="/usr/local/lib/node_modules"

# Prefer /usr/local/bin over /usr/bin
export PATH="/usr/local/bin:$PATH:$HOME/bin"
export PATH="/usr/local/sbin:$PATH"

# HDF5 utils.
export PATH="/usr/local/opt/hdf5@1.8/bin:$PATH"

# Prefer Postgres.app's binaries.
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# Make Haskell's stuff available
export PATH="$HOME/Library/Haskell/bin:$PATH"

# Go
export PATH="$PATH:/usr/local/opt/go/libexec/bin"
#export GOROOT="/usr/local/opt/go/libexec/bin"

# Yarn
export PATH="$PATH:`yarn global bin`"

# Load stuff for android
if [ -e ~/Library/Android/sdk/platform-tools ]; then
    export PATH=${PATH}:~/Library/Android/sdk/tools
    export PATH=${PATH}:~/Library/Android/sdk/platform-tools
fi

# Packer
export PATH="/usr/local/packer:$PATH"

# create some environment variables for svn
export SVN_EDITOR=/usr/bin/vi
export VISUAL=/usr/bin/vi
export EDITOR=/usr/bin/vi

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

function pyg()
{
    if [ -z "$1" ]; then
        echo "USAGE: pyg <input>"
    else
        echo "Running: pygmentize -f rtf $1 | pbcopy"
        pygmentize -f rtf $1 | pbcopy
    fi
}

function png2gif
{
    ## TODO: Make -r <rate> an input value.
    if [ -z "$1" ]; then
        echo "USAGE: png2gif <Filename> -- provide filename without -x.png, "
        echo "     e.g. ToastFox-1.png, ToastFox-2.png --> png2gif ToastFox "
    else
        FILE_PATTERN="$1-%d.png";
        OUTPUT="$1.gif";
        ffmpeg -f image2 -i $FILE_PATTERN -vcodec copy tmp-video.mkv && \
        ffmpeg -i tmp-video.mkv -pix_fmt rgb24 -loop 0 -r 5 $OUTPUT;
        rm tmp-video.mkv
    fi
}

function jpg2gif
{
    # TODO: Make -r <rate> an input value.
    # TODO: figure out how to control speed :-/
    if [ -z "$1" ]; then
        echo "USAGE: jpg2gif <Filename> -- provide filename without -x.jpg, "
        echo "     e.g. ToastFox-1.jpg, ToastFox-2.jpg --> jpg2gif ToastFox "
    else
        FILE_PATTERN="$1-%d.jpg";
        OUTPUT="$1.gif";
        ffmpeg -f image2 -i $FILE_PATTERN -vcodec copy tmp-video.mkv && \
        ffmpeg -i tmp-video.mkv -pix_fmt rgb24 -loop 0 -r 20 -frames 6 -vframes 6 $OUTPUT;
        rm tmp-video.mkv
    fi
}


function timerequest
{
    # Use curl to TIME http requests.
    # Inspired by this: http://stackoverflow.com/a/22625150/182778

   FMT="
         http_code:  %{http_code}
     size_download:  %{size_download}
       size_header:  %{size_header}
    speed_download:  %{speed_download}\n
   time_namelookup:  %{time_namelookup}
      time_connect:  %{time_connect}
   time_appconnect:  %{time_appconnect}
  time_pretransfer:  %{time_pretransfer}
     time_redirect:  %{time_redirect}
time_starttransfer:  %{time_starttransfer}
                   ----------
        time_total:  %{time_total}
    "
    curl -w "$FMT" -o /dev/null -s $1
}


function fnd
{
    # find but with a syntax I can remember.
    if [ -z "$1" ]; then
        echo "USAGE: fnd <pattern>"
    else
        find . -name "$1" -print
    fi
}

# http://osxdaily.com/2013/12/27/fix-there-is-no-connected-camera-error-mac/
function fixCamera {
    sudo killall AppleCameraAssistant;
    sudo killall VDCAssistant;
}

# Aliases
alias ls='ls -G'
alias ll='ls -lhG'
alias l='ls -lhG'
alias la='ls -ahG'
alias hig='history | grep --color'
alias top=htop
alias get=git
alias gti=git
alias br='git branch'
alias st='git status'
alias prune='git remote prune origin'
alias knive=knife
alias VAGRANTDESTROY='vagrant destroy'
alias clera=clear
alias claer=clear
alias tail='less +F'

# Nifty Python Aliases
alias nosetests="nosetests --with-yanc"
alias email='python -m smtpd -n -c DebuggingServer localhost:1025'
alias serve='python -m SimpleHTTPServer'
alias rmpyc='find ./ -type f -name "*.pyc" -exec rm {} \;'
alias mp3player="find . -name '*.mp3' -exec afplay '{}' \;"
alias m4aplayer="find . -name '*.m4a' -exec afplay '{}' \;"
alias ipython_console="ipython qtconsole --pylab=inline"
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

# Opscode/Chef stuff
export OPSCODE_ORGNAME="workforpie"
export OPSCODE_USER="workforpie"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Load the secret env vars.
source $HOME/Dropbox/dotfiles/secrets.sh
source $HOME/Dropbox/dotfiles/preteckt.sh

if hash thefuck 2>/dev/null; then
    eval "$(thefuck --alias)"
fi

# Make sure our ssh keys actually work like they're supposed to :-/
# http://apple.stackexchange.com/a/254714/58762
ssh-add -A 2>/dev/null;

# Rust!
export PATH="$HOME/.cargo/bin:$PATH"

# Setting PATH for Python 3.6
# The original version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# autoenv
source /usr/local/opt/autoenv/activate.sh

# direnv
if hash direnv 2>/dev/null; then
    eval "$(direnv hook bash)"
fi


# autoenv
if [ -d "/usr/local/opt/autoenv/" ]; then
    source /usr/local/opt/autoenv/activate.sh
fi
