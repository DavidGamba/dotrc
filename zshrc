#-------------------------------------------------------------
# setopt (man zshoptions)
#-------------------------------------------------------------
setopt No_Beep
setopt PROMPT_SUBST # Enable expansion in the prompt.

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
