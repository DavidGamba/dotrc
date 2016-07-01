# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [ -z "$PS1" ] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

#-------------------------------------------------------------
# Shell opts: see bash(1)
#-------------------------------------------------------------
set -o vi                   # vi style
set -o notify               # notify of completed background jobs immediately
stty -ctlecho               # turn off control character echoing
stty -ixon                  # Enable XON/XOFF flow control, allows passing Ctrl-S to vim
setterm -regtabs 2          # set tab width of 4 (only works on TTY)

# shell opts: see bash(1)
shopt -s cdable_vars        # if cd arg fail, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
shopt -s checkhash          # checks that a command found in the  hash
                            # table  exists before  trying to execute it.
shopt -s checkwinsize       # update LINES and COLUMNS after each command if altered
shopt -s cmdhist            # save multi-line commands in history as single line
shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases     # expand aliases
shopt -s extglob            # enable extended pattern-matching features
shopt -s histappend         # Make bash append rather than overwrite the history on disk
shopt -s histverify         # edit a recalled history line before executing
shopt -s histreedit         # reedit a history substitution line if it failed
shopt -s hostcomplete       # attempt hostname expansion when @ is at the beginning of a word
shopt -s nocaseglob         # pathname expansion will be treated as case-insensitive
shopt -s no_empty_cmd_completion

#-------------------------------------------------------------
# Exports
#-------------------------------------------------------------
export EDITOR="nvim"
export GIT_EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-I -j6 -M -R -F -X"
export HOSTFILE=$HOME/.hosts    # Put list of remote hosts in ~/.hosts
#LESSOPEN="|lesspipe.sh %s"
#export LESSOPEN

# History Stuff
export HISTTIMEFORMAT="%H:%M > "
export HISTIGNORE="&:[bf]g:clear:exit"
export HISTSIZE=90000
export HISTFILESIZE=$HISTSIZE
export HISTCONTROl=ignoreboth

#-------------------------------------------------------------
# Aliases
#-------------------------------------------------------------
# Darwin = mac
if [ `uname | grep Darwin` ]; then
    # G is color in mac
    alias ls='ls -GhF'
    alias ll='ls -Gl'
    alias la='ls -Gla'
    alias l='ls -GCF'
    alias chromium='/Applications/Chromium.app/Contents/MacOS/Chromium'
else
    alias ls='ls -hF --color=auto'
    alias ll='ls -l --color=auto'
    alias la='ls -la --color=auto'
    alias l='ls -CF --color=auto'
fi
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
#alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias pong='ping -c4 www.google.com' 
# alias emacs="emacs -nw"
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# to run banshee behind a proxy
alias banshee='dbus-launch banshee'
alias nautilus='nautilus --no-desktop'
alias most='du -hsx * | sort -rh | head -15'
alias df='df -hlT --exclude-type=tmpfs --exclude-type=devtmpfs'
alias vim=nvim
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'

#-------------------------------------------------------------
# External
#-------------------------------------------------------------
if [ -f ${HOME}/local/bash_local.bash ]; then
    source ${HOME}/local/bash_local.bash
fi

if [ -d ${HOME}/bin ]; then
    export PATH="$PATH:$HOME/bin"
    alias open="$HOME/bin/open"
fi

if [ -d ${HOME}/opt/bin ]; then
    export PATH="$PATH:$HOME/opt/bin"
fi
if [ -d ${HOME}/local/bin ]; then
    export PATH="$PATH:$HOME/local/bin"
fi

if [ ! -f /etc/bash_completion.d/git ]; then
    source ~/dotrc/bash_func/git-completion.bash
fi

if [ -e /usr/lib/jvm/JAVA_HOME ]; then
  export JAVA_HOME=/usr/lib/jvm/JAVA_HOME
elif [ -e /usr/java/default ]; then
  export JAVA_HOME=/usr/java/default
fi

source ~/dotrc/bash_func/up
source ~/dotrc/bash_func/color_less.bash # Colored man pages and less output
source ~/dotrc/bash_func/ps1.bash        # Custom PS1
source ~/dotrc/bash_func/cdd

if [ -f /usr/share/doc/cdargs/examples/cdargs-bash.sh ]; then
  source /usr/share/doc/cdargs/examples/cdargs-bash.sh
fi

if [ -f /etc/arch-release ]; then
    source ~/dotrc/bash_func/arch
fi

if [ -d $HOME/code/personal/git/go/bin ]; then
  export PATH="$PATH:$HOME/code/personal/git/go/bin"
fi
if [ -d $HOME/code/personal/git/gocode/bin ]; then
  export GOPATH="$HOME/code/personal/git/gocode"
  export GOBIN="$HOME/code/personal/git/gocode/bin"
  export PATH="$PATH:$GOBIN"
fi

#-------------------------------------------------------------
# Define BROWSER and EDITOR
#-------------------------------------------------------------
if [ "$DISPLAY" ] ; then
    for browser in iceweasel firefox mozilla ; do
        if command -v $browser &> /dev/null ; then
            export BROWSER=`command -v $browser`
            break
        fi
    done
else
    for browser in w3m links ; do
        if command -v $browser &> /dev/null ; then
            export BROWSER=`command -v $browser`
            break
        fi
    done
fi

for editor in vim vi editor ; do
    if command -v $editor &> /dev/null ; then
        export EDITOR=`command -v $editor`
        break
    fi
done

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Ruby stuff
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

alias cd='cdd'
# Use bash built in completion for cd to allow for filenames to be used
complete -r cd
