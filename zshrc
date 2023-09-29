#-------------------------------------------------------------
# setopt (man zshoptions)
#-------------------------------------------------------------
setopt No_Beep
setopt PROMPT_SUBST # Enable expansion in the prompt.
setopt INC_APPEND_HISTORY_TIME # Save to history immediately but don't immediately share with other shells.

#-------------------------------------------------------------
# Vi mode
#-------------------------------------------------------------
bindkey -v
bindkey ^r history-incremental-search-backward 
bindkey ^w backward-kill-word

[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor

#-------------------------------------------------------------
# Completion
#-------------------------------------------------------------

zmodload -i zsh/complist

# setopt EQUALS
setopt AUTO_LIST
setopt AUTO_MENU
# setopt COMPLETE_IN_WORD
# setopt ALWAYS_TO_END

# '^D' list completions

# bindkey '^I' complete-word # Tab only does completion, not expansion
bindkey '^I' expand-or-complete-prefix # Tab only does completion, not expansion
bindkey '^[[Z' reverse-menu-complete # Shift-Tab to go backwards

bindkey -M menuselect '^O' accept-and-infer-next-history
zstyle ':completion:*' menu select=2


#-------------------------------------------------------------
# Path
#-------------------------------------------------------------
source "$HOME/dotrc/shell_func/path.sh"

#-------------------------------------------------------------
# Exports
#-------------------------------------------------------------
export ZSHELL="true"
export EDITOR="nvim"
export GIT_EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-I -j6 -M -R -X"

# History Stuff
export HISTTIMEFORMAT="%H:%M > "
export HISTIGNORE="&:[bf]g:clear:exit"
export HISTSIZE=9000000
export HISTFILESIZE=$HISTSIZE
export HISTCONTROl=ignoreboth

# Get help working
export HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
unalias run-help 2>/dev/null
autoload run-help
alias help=run-help

#-------------------------------------------------------------
# Aliases
#-------------------------------------------------------------
source "$HOME/dotrc/shell_func/alias.sh"

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

source ~/dotrc/shell_func/ps1.zsh
source ~/dotrc/shell_func/up.sh
source ~/dotrc/shell_func/clear.sh
source ~/dotrc/shell_func/cdd.sh
source ~/dotrc/shell_func/cli-bookmarks.bash
alias cd='cdd'
# Use bash built in completion for cd to allow for filenames to be used
complete -r cd 2>/dev/null

complete -o default -C bt bt
complete -o default -C cssh cssh
complete -o default -C csvtable csvtable
complete -o default -C diffdir diffdir
complete -o default -C ffind ffind
complete -o default -C grepp grepp
complete -o default -C joinlines joinlines
complete -o default -C json-parse json-parse
complete -o default -C kcherry kcherry
complete -o default -C password-cache password-cache
complete -o default -C patch-seam patch-seam
complete -o default -C reverseproxy reverseproxy
complete -o default -C wardley wardley
complete -o default -C webserve webserve
complete -o default -C yaml-parse yaml-parse
complete -o default -C yaml-seam yaml-seam

#-------------------------------------------------------------
# Overrides
#-------------------------------------------------------------
if [ -f "$HOME/private-bin/private.zshrc" ]; then
  source "$HOME/private-bin/private.zshrc"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
