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
export EDITOR="vim"
export GIT_EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
export LESS="-I -j6 -M -R -F -X"
export HOSTFILE=$HOME/.hosts    # Put list of remote hosts in ~/.hosts
#LESSOPEN="|lesspipe.sh %s"
#export LESSOPEN

# History Stuff
export HISTTIMEFORMAT="%H:%M > "
export HISTIGNORE="&:[bf]g:ll:h:ls:clear:exit"
export HISTSIZE=9000
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
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# to run banshee behind a proxy
alias banshee='dbus-launch banshee'
alias nautilus='nautilus --no-desktop'

#-------------------------------------------------------------
# External
#-------------------------------------------------------------
if [ -f ${HOME}/local/bash_aliases ]; then
    source ${HOME}/local/bash_aliases
fi

if [ -d ${HOME}/bin ]; then
    export PATH="$HOME/bin:$PATH"
fi

if [ -d ${HOME}/opt/bin ]; then
    export PATH="$HOME/opt/bin:$PATH"
fi

if [ -d ${HOME}/.cabal/bin ]; then
    export PATH="$HOME/.cabal/bin:$PATH"
fi

if [ ! -f /etc/bash_completion.d/git ]; then
    source ~/dotrc/bash_func/git-completion.bash
fi

source ~/dotrc/bash_func/up
source ~/dotrc/bash_func/color_less.bash # Colored man pages and less output
source ~/dotrc/bash_func/ps1.bash        # Custom PS1

if [ -f /etc/arch-release ]; then
    source ~/dotrc/bash_func/arch
fi

if [ -d "/usr/lib/oracle/11.2" ]; then
    if [ -d "/usr/lib/oracle/11.2/client" ]; then
        export ORACLE_HOME="/usr/lib/oracle/11.2/client"
    fi
    if [ -d "/usr/lib/oracle/11.2/client64" ]; then
        export ORACLE_HOME="/usr/lib/oracle/11.2/client64"
    fi
    export PATH="$PATH:$ORACLE_HOME/bin"
    export LD_LIBRARY_PATH="$ORACLE_HOME/lib"
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
