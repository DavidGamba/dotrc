function git_repo {
    PROMT_CHAR='$'
    GIT_BRANCH=`git rev-parse --abbrev-ref HEAD 2>/dev/null` &&\
        GIT_BRANCH=" $GIT_BRANCH" &&\
        PROMT_CHAR='$'
}

function smiley {
    [ $RET -eq 0 ] && echo -ne "👌"
    [ $RET -ne 0 ] && echo -ne "⛔ 🙄 ⛔"
    # [ $RET -ne 0 ] && echo -ne "\e[31;1m:("
}

function k8s_ps1 {
	K8S_CONTEXT=$(kubectl config view --minify --output 'jsonpath={.clusters[].name} {..namespace}' 2>/dev/null)
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

    # insert \[ and \] around the ANSI escapes so that the shell knows not
    # to include them in the line wrapping calculation
    local CB="\[\e[0m\]\[\e[" # Color Begin
    local CE="m\]"   # Color End
    local TERM_RESET="\[\017\]"

    local PS1_START_MARK="\[\e]133;A\a\]"
    local PS2_START_MARK="\[\e]133;A;k=s\a\]"
    local COMMAND_START_MARK="\[\e]133;C\a\]"

    HOST_COLOR=${CYAN}
    if [[ $(uname -a) =~ "amzn2" ]]; then
        HOST_COLOR=${MAGENTA}
    elif [[ $(uname -a) =~ "Ubuntu" ]]; then
        HOST_COLOR=${MAGENTA}
    fi

    local TERM_TITLE="\[\033]2; \h \w\007\]"
    local FIRST_LINE="${CB}${B_DEFAULT};${HOST_COLOR};${BOLD}${CE}\h ${CB}${FAINT};${HOST_COLOR}${CE}\D{%F %T} ${CB}${CYAN}${CE}\w${CB}${DEFAULT};${RESET}${CE} \$(smiley)${CB}${HOST_COLOR};${NORMAL}${CE} \${GIT_BRANCH} ${CB}${GREEN};${NORMAL}${CE}\${K8S_CONTEXT}"
    local SECOND_LINE="\n${CB}${B_DEFAULT};${BLUE};${BOLD}${CE}\${PROMT_CHAR} "
    local REGULAR_TEXT="${CB}${DEFAULT};${RESET}${CE}"
    PS1=${TERM_RESET}${PS1_START_MARK}${TERM_TITLE}${FIRST_LINE}${SECOND_LINE}${REGULAR_TEXT}${COMMAND_START_MARK}
}

PROMPT_COMMAND='RET=$?; stty sane; tput rmacs; history -a; git_repo; k8s_ps1'
ps1
