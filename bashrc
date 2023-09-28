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
bind 'set completion-ignore-case on'

stty -ctlecho               # turn off control character echoing
stty -ixon                  # Enable XON/XOFF flow control, allows passing Ctrl-S to vim

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
# Path
#-------------------------------------------------------------
source "$HOME/dotrc/shell_func/path.sh"

#-------------------------------------------------------------
# Exports
#-------------------------------------------------------------
export EDITOR="nvim"
export GIT_EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-I -j6 -M -R -X"
export HOSTFILE=$HOME/.hosts    # Put list of remote hosts in ~/.hosts
#LESSOPEN="|lesspipe.sh %s"
#export LESSOPEN

if [[ $(uname -a) =~ "amzn2" ]]; then
    export TERM=tmux-256color
fi

# History Stuff
export HISTTIMEFORMAT="%H:%M > "
export HISTIGNORE="&:[bf]g:clear:exit"
export HISTSIZE=9000000
export HISTFILESIZE=$HISTSIZE
export HISTCONTROl=ignoreboth

#-------------------------------------------------------------
# Aliases
#-------------------------------------------------------------
source "$HOME/dotrc/shell_func/alias.sh"

#-------------------------------------------------------------
# SSH agent on WSL
# https://stackoverflow.com/a/45562886
#-------------------------------------------------------------
if [[ $(uname -r) =~ "microsoft" ]]; then
	# Set up ssh-agent
	SSH_ENV="$HOME/.ssh/environment"

	function start_agent {
			echo "Initializing new SSH agent..."
			touch "$SSH_ENV"
			chmod 600 "${SSH_ENV}"
			/usr/bin/ssh-agent | sed 's/^echo/#echo/' >> "${SSH_ENV}"
			source "${SSH_ENV}" > /dev/null
			/usr/bin/ssh-add
	}

	# Source SSH settings, if applicable
	if [ -f "${SSH_ENV}" ]; then
			source "${SSH_ENV}" > /dev/null
			kill -0 "$SSH_AGENT_PID" 2>/dev/null || {
					start_agent
			}
	else
			start_agent
	fi
fi

#-------------------------------------------------------------
# External
#-------------------------------------------------------------
if [ ! -f /etc/bash_completion.d/git ]; then
    source ~/dotrc/bash_func/git-completion.bash
fi

if [ -e /usr/lib/jvm/JAVA_HOME ]; then
  export JAVA_HOME=/usr/lib/jvm/JAVA_HOME
elif [ -e /usr/lib/jvm/java ]; then
  export JAVA_HOME=/usr/lib/jvm/java
elif [ -e /usr/java/default ]; then
  export JAVA_HOME=/usr/java/default
fi

source ~/dotrc/bash_func/up
source ~/dotrc/bash_func/man_colors.bash # Colored man pages and less output
source ~/dotrc/bash_func/ps1.bash        # Custom PS1
source ~/dotrc/bash_func/cdd
source ~/dotrc/bash_func/cli-bookmarks.bash
source ~/dotrc/bash_func/ls_colors.bash

if [ -f /etc/arch-release ]; then
    source ~/dotrc/bash_func/arch
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

for editor in nvim vim vi editor ; do
    if command -v $editor &> /dev/null ; then
        export EDITOR=`command -v $editor`
        break
    fi
done

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  source /etc/bash_completion
fi

# brew install bash-completion@2
export BASH_COMPLETION_COMPAT_DIR="/opt/homebrew/etc/bash_completion.d/"
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"


# for PyEnv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$HOME/.pyenv/bin:$PATH"
# export PATH="$HOME/.pyenv/shims:$PATH"
# eval "$(pyenv init -)"

# Ruby stuff
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

alias cd='cdd'
# Use bash built in completion for cd to allow for filenames to be used
complete -r cd 2>/dev/null

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# local bash overrides defaults
if [ -f "$HOME/local/bash_local.bash" ]; then
  source "$HOME/local/bash_local.bash"
fi
if [ -f "$HOME/private-bin/private.bashrc" ]; then
  source "$HOME/private-bin/private.bashrc"
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

complete -o default -C csvtable csvtable
complete -o default -C cssh cssh
complete -o default -C diffdir diffdir
complete -o default -C ffind ffind
complete -o default -C grepp grepp
complete -o default -C joinlines joinlines
complete -o default -C json-parse json-parse
complete -o default -C kcherry kcherry
complete -o default -C password-cache password-cache
complete -o default -C patch-seam patch-seam
complete -o default -C reverseproxy reverseproxy
complete -o default -C tz tz
complete -o default -C wardley wardley
complete -o default -C webserve webserve
complete -o default -C yaml-parse yaml-parse
complete -o default -C yaml-seam yaml-seam

complete -C /opt/homebrew/bin/aws_completer aws

# Consider personal repos as private and don't check their checksums against Go Proxy
export GOPRIVATE="${GOPRIVATE}:github.com/DavidGamba"

# Depends on https://github.com/scop/bash-completion#installation
source <(kubectl completion bash)
source <(kubectl completion bash | sed 's/kubectl/k/g')
# alias k=kubectl
# complete -o default -F __start_kubectl k

source "$HOME/.cargo/env"
source "/opt/homebrew/opt/asdf/libexec/asdf.sh"

export KUSTOMIZE_DIR=$HOME/.kustomize
