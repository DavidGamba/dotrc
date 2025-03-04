function ps1_git_branch {
	local orange="f14e32"
	local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
	if [[ -n $branch ]]; then
		# echo -ne " %S%k%F{#$orange} %s%k%F{#$orange}%k%F{#0388a6} $branch"
		echo -ne " %F{#$orange} %F{#0388a6} $branch"
	fi
}

function k8s_ps1 {
	local blue="326CE5"
	# echo -ne " %S%k%F{#$blue} 󱃾 %s%k%F{#$blue}%k "
	echo -ne "%F{#$blue} 󱃾 "
	# This is too slow!
	# kubectl config view --minify --output 'jsonpath={.contexts[].name}/{..namespace}' 2>/dev/null
	kgetcontext 2>/dev/null
}

function kubie_shell {
	[[ -n $KUBIE_ACTIVE ]] && echo -ne " 🐱"
}

function aws_shell {
	[[ -n $AWS_OKTA_PROFILE ]] && echo -ne " %F{#FF9900}󰅠 %F{#d37e00}$AWS_OKTA_PROFILE"
}

function ps1 {
    local BLACK="30"
    local RED="31"
    local GREEN="32"
    local YELLOW="33"
    local BLUE="34"
    local MAGENTA="35"
    local CYAN="36"
    local WHITE="37"
    local DEFAULT="39"

    # Background
    local B_BLACK="40"
    local B_RED="41"
    local B_GREEN="42"
    local B_YELLOW="43"
    local B_BLUE="44"
    local B_MAGENTA="45"
    local B_CYAN="46"
    local B_WHITE="47"
    local B_DEFAULT="49"

    local RESET="0"
    local BOLD="1"
    local FAINT="2"
    local ITALIC="3"
    local NORMAL="22"
    local UNDERLINE="4"
    local BLINK_SLOW="5"
    local BLINK_FAST="6"
    local REVERSE="7"

    HOST_COLOR=${CYAN}
    if [[ $(uname -a) =~ "amzn2" ]]; then
        HOST_COLOR=${MAGENTA}
    elif [[ $(uname -a) =~ "Ubuntu" ]]; then
        HOST_COLOR=${MAGENTA}
    fi
		builtin local ps1_start_mark=$'%{\e]133;A\a%}'
		builtin local ps2_start_mark=$'%{\e]133;A;k=s\a%}'
		builtin local cmd_start_mark=$'%{\e]133;C\a%}'

		PS1=${ps1_start_mark}$'%F{36}%m %F{2;36}%D %* %F{#44c9c9}%~%f %(?.👌.⛔ 🙄 ⛔)$(ps1_git_branch)$(k8s_ps1)$(kubie_shell)$(aws_shell)
'${ps2_start_mark}'%F{#8360d1}%(!.#.$)%f '${cmd_start_mark}
}

# precmd () { RET=$?; stty sane; tput rmacs; history -a; git_repo; k8s_ps1}
ps1
