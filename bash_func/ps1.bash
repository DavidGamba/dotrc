function git_repo {
    PROMT_CHAR='$'
    GIT_BRANCH=`git rev-parse --abbrev-ref HEAD 2>/dev/null` &&\
        GIT_BRANCH=" $GIT_BRANCH" &&\
        PROMT_CHAR='+'
}
function smiley {
    [ $RET -eq 0 ] && echo -ne "\e[37;1m:)"
    [ $RET -ne 0 ] && echo -ne "\e[31;1m:("
}
function ps1() {
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

    local TERM_TITLE="\[\033]2; \h \w\007\]"
    local FIRST_LINE="${CB}${B_DEFAULT};${CYAN};${BOLD}${CE}\h ${CB}${FAINT};${CYAN}${CE}\D{%F %T} ${CB}${CYAN}${CE}\w${CB}${DEFAULT};${RESET}${CE} \$(smiley)${CB}${CYAN};${NORMAL}${CE} \${GIT_BRANCH}"
    local SECOND_LINE="\n${CB}${B_DEFAULT};${BLUE};${BOLD}${CE}\${PROMT_CHAR} "
    local REGULAR_TEXT="${CB}${DEFAULT};${RESET}${CE}"
    PS1=${TERM_RESET}${TERM_TITLE}${FIRST_LINE}${SECOND_LINE}${REGULAR_TEXT}
}

PROMPT_COMMAND='RET=$?; stty sane; tput rmacs; history -a; git_repo'
ps1
