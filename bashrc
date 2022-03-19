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
# PATH
# Scripts modifying the path should used the path_append function to append
# entries. These external entries not tracked in the bashrc will have lower priority.
#-------------------------------------------------------------
function path_append() {
	if [[ "$PATH" =~ (^|:)"${1}"(:|$) ]]; then
		return 0
	fi
	PATH=$PATH:$1
}

function path_prepend() {
	if [[ "$PATH" =~ (^|:)"${1}"(:|$) ]]; then
		return 0
	fi
	if [[ "$PATH" == "" ]]; then
		PATH=$1
		return 0
	fi
	PATH=$1:$PATH
}

# Clear the PATH to ensure the right ordering
PATH=""
# Lowest priority at the top

if [[ $(/usr/bin/uname -r) =~ "microsoft" ]]; then
	path_prepend "/mnt/c/tools/neovim/Neovim/bin"
	path_prepend "/mnt/c/Users/David/AppData/Local/Programs/Microsoft VS Code/bin"
	path_prepend "/mnt/c/Users/David/AppData/Local/Microsoft/WindowsApps"
	path_prepend "/mnt/c/ProgramData/chocolatey/bin"
	path_prepend "/mnt/c/WINDOWS/System32/OpenSSH/"
	path_prepend "/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/"
	path_prepend "/mnt/c/WINDOWS/System32/Wbem"
	path_prepend "/mnt/c/WINDOWS"
	path_prepend "/mnt/c/WINDOWS/system32"
fi

path_prepend "$HOME/.local/bin" # Python binaries
path_prepend "$HOME/.cargo/bin" # Rust binaries
path_prepend "$HOME/go/bin"     # Go binaries
path_prepend "/snap/bin"        # Snap binaries
path_prepend "$HOME/local/bin"
path_prepend "$HOME/opt/bin"
path_prepend "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin"
path_prepend "$HOME/bin"
path_prepend "$HOME/private-bin"

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
# alias asciidoctor='docker run --rm -v $(pwd):/documents/ asciidoctor/docker-asciidoctor asciidoctor'
alias path='PATH="${PATH//":$PWD"/}:$PWD"; echo $PATH'
alias rg='rg -i --color=always -u'
alias ccat='source-highlight --out-format=esc -o STDOUT -i'
alias color='source-highlight --out-format=esc -o STDOUT -s'
alias csvlook='csvlook -I | less -S'
# alias csvtable='csvtable | less -S'
alias asciicast2gif='docker run --rm -v $PWD:/data asciinema/asciicast2gif'
alias myip="curl https://ifconfig.co"
alias tinit='time ./terraform init'
alias tplan='time ./terraform plan -no-color -out tf.plan'
alias tapply='time ./terraform apply -input tf.plan && rm tf.plan'
alias tcopy='./terraform show -no-color tf.plan | copy'
alias tshow='./terraform show tf.plan'

if [[ $(uname -r) =~ "microsoft" ]]; then
	alias copy='win32yank.exe -i'
	alias copy-file='win32yank.exe -i <<<'
	alias copy-path='pwd | tr -d "\n" | win32yank.exe -i'
elif [[ $(uname) =~ "Darwin" ]]; then
	alias copy-file='pbcopy <'
	alias copy-path='pwd | tr -d "\n" | pbcopy'
else
	# alias copy-file="xsel -i -b < "
	alias copy-file='xclip -selection clipboard'
	alias copy-path='pwd | tr -d "\n" | xclip -selection clipboard'
fi

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
			. "${SSH_ENV}" > /dev/null
			/usr/bin/ssh-add
	}

	# Source SSH settings, if applicable
	if [ -f "${SSH_ENV}" ]; then
			. "${SSH_ENV}" > /dev/null
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
    . /etc/bash_completion
fi


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
if [ -f "${HOME}/local/bash_local.bash" ]; then
    . "${HOME}/local/bash_local.bash"
fi
if [ -f "${HOME}/private-bin/private.bashrc" ]; then
    . "${HOME}/private-bin/private.bashrc"
fi

complete -o default -C diffdir diffdir
complete -o default -C ffind ffind
complete -o default -C grepp grepp
complete -o default -C joinlines joinlines
complete -o default -C password-cache password-cache
complete -o default -C wardley wardley
complete -o default -C webserve webserve
complete -o default -C yaml-parse yaml-parse
complete -o default -C reverseproxy reverseproxy

complete -C $HOME/opt/bin/aws_completer aws

# Consider personal repos as private and don't check their checksums against Go Proxy
export GOPRIVATE="${GOPRIVATE}:github.com/DavidGamba"
