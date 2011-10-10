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
shopt -s histappend
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
export LESS="-I -j6 -M -F -X -R"
export HOSTFILE=$HOME/.hosts    # Put list of remote hosts in ~/.hosts
LESSOPEN="|lesspipe.sh %s"
export LESSOPEN

# History Stuff
export HISTTIMEFORMAT="%H:%M > "
export HISTIGNORE="&:[bf]g:ll:h:ls:clear:exit"
export HISTSIZE=9000
export HISTFILESIZE=$HISTSIZE
export HISTCONTROl=ignoreboth

#-------------------------------------------------------------
# Aliases
#-------------------------------------------------------------
alias ls='ls -hF --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
#alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias pong='ping -c4 www.google.com' 

#-------------------------------------------------------------
# External
#-------------------------------------------------------------
if [ -d ${HOME}/.local_bash ]; then
    source ${HOME}/.local_bash/bash_aliases
fi

if [ -d ${HOME}/bin ]; then
    export PATH="$HOME/bin:$PATH"
fi

if [ ! -f /etc/bash_completion.d/git ]; then
    source ~/dotrc/bash_func/git-completion.bash
fi

source ~/dotrc/bash_func/up

if [ -f /etc/arch-release ]; then
    source ~/dotrc/bash_func/arch
fi

#-------------------------------------------------------------
# PS1
#-------------------------------------------------------------
#colors
RESET="\[\017\]"
NORMAL="\[\033[0m\]"
RED="\[\033[31;1m\]"
GREEN="\[\033[32;1m\]"
YELLOW="\[\033[33;1m\]"
BLUE="\[\033[34;1m\]"
CYAN="\[\033[36;1m\]"
WHITE="\[\033[37;1m\]"
# insert \[ and \] around the ANSI escapes so that the shell knows not
# to include them in the line wrapping calculation

function git_repo {
    PROMT_CHAR='$'
    GIT_BRANCH=`git rev-parse --abbrev-ref HEAD 2>/dev/null` &&\
        GIT_BRANCH=" $GIT_BRANCH" &&\
        PROMT_CHAR='+'
}
function smiley {
    [ $RET -eq 0 ] && echo -ne "\033[37;1m:)"
    [ $RET -ne 0 ] && echo -ne "\033[31;1m:("
}
PROMPT_COMMAND='RET=$?; stty sane; tput rmacs; git_repo'
PS1="${RESET}${CYAN}\h \w \$(smiley)${GREEN}\${GIT_BRANCH}"\
"\n${BLUE}\${PROMT_CHAR} ${NORMAL}${RESET}"

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
