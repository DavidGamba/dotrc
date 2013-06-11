set_less_color_env_vars() {
    local BLACK="30"
    local RED="31"
    local GREEN="32"
    local YELLOW="33"
    local BLUE="34"
    local MAGENTA="35"
    local CYAN="36"
    local WHITE="37"
    local DEFAULT="39"

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

    # start each sentence with '"\e[', then add your commands separating
    # each with ';' and finish the sentence with 'm'.
    # mb   Start blinking
    # md   Start bold mode
    # me   End all mode like so, us, mb, md and mr
    # se   End standout mode
    # so   Start standout mode
    # ue   End underlining
    # us   Start underlining

    export LESS_TERMCAP_mb=$(printf "\e[${RED};${BOLD}m")
    export LESS_TERMCAP_md=$(printf "\e[${CYAN};${BOLD}m")
    export LESS_TERMCAP_me=$(printf "\e[${RESET}m")
    export LESS_TERMCAP_se=$(printf "\e[${RESET}m")
    export LESS_TERMCAP_so=$(printf "\e[${BLACK};${B_BLUE};${NORMAL}m")
    export LESS_TERMCAP_ue=$(printf "\e[${RESET}m")
    export LESS_TERMCAP_us=$(printf "\e[${GREEN};${BOLD}m")
}
set_less_color_env_vars
