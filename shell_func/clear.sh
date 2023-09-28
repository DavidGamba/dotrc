# clear screen and save scrollback
clear() {
	printf "\\033[H\\033[22J"
}
