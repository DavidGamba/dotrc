#!/bin/bash

CODE_DIR=$HOME/general/code
PROJECTS_DIR=$HOME/general

function usage() {
	option=$1
	if [[ -n "$option" ]]; then
		cat <<EOL
Invalid argument: '$option'

EOL
	fi
	cat <<EOL
	install -h|--help

	install [--bin] [--dotrc] [--nvim] [--utils]
EOL
}

function main() {
	while test $# -gt 0 ; do
		case "$1" in
			-h|--help)
				usage
				exit 1
				;;
			--dotrc)
				shift
				echo installing dotrc...
				install_dotrc
				install_fzf
				exit 0
				;;
			--bin)
				shift
				echo installing bin...
				install_bin
				exit 0
				;;
			--nvim)
				shift
				echo installing nvim...
				install_nvim
				exit 0
				;;
			--utils)
				shift
				echo installing golang utils...
				install_go_utils
				exit 0
				;;
			-*)
				usage $1
				exit 1
				;;
		esac
	done
	usage
	exit 1
}

function create_link_for() {
	link=$1
	dest=$2
	if [[ ! -e "$link" && ! -L "$link" ]]; then
		echo "creating link '$link'"
		set -x
		ln -s $dest $link
		set +x
	else
		if [[ `readlink "$link"` != "$dest" ]]; then
			set -x
			readlink $link
			rm $link
			set +x
			if [[ $? -eq 0 ]]; then
				create_link_for $link $dest
			else
				return 1
			fi
		fi
	fi
}

function install_dotrc() {
	mkdir -p $HOME/opt
	mkdir -p $HOME/mnt
	mkdir -p $HOME/.config/nvim
	mkdir -p $CODE_DIR
	mkdir -p $PROJECTS_DIR

	create_link_for "$HOME/.bashrc"     "dotrc/bashrc"
	create_link_for "$HOME/.screenrc"   "dotrc/screenrc"
	create_link_for "$HOME/.tmux.conf"  "dotrc/tmux.conf"
	create_link_for "$HOME/.perltidyrc" "dotrc/perltidyrc"
	create_link_for "$HOME/.inputrc"    "dotrc/inputrc"
	create_link_for "$HOME/.gitignore"  "dotrc/gitignore"
	create_link_for "$HOME/.gitconfig"  "dotrc/gitconfig"
	create_link_for "$HOME/.hgrc"       "dotrc/hgrc"
	create_link_for "$HOME/.nvimrc"     "dotrc/nvimrc"
	create_link_for "$HOME/.config/nvim/init.vim" "$HOME/dotrc/nvimrc"

	echo done installing dotrc!
}

function clone_repo() {
	local repo=$1
	shift
	local dir=$1
	shift
	local gitopts=$1
	shift

	if [[ ! -d $dir ]]; then
		mkdir -p `dirname $dir`
		set -x
		git clone $gitopts $repo $dir
		set +x
	fi
}

function install_bin() {
	clone_repo git@github.com:DavidGamba/bin.git   $HOME/bin
	clone_repo git@github.com:DavidGamba/grepp.git $CODE_DIR/grepp
	clone_repo git@github.com:DavidGamba/ffind.git $CODE_DIR/ffind
	clone_repo git@github.com:DavidGamba/cli-bookmarks.git $CODE_DIR/cli-bookmarks
	create_link_for "$HOME/bin/grepp" "$CODE_DIR/grepp/grepp"
	create_link_for "$HOME/bin/ffind" "$CODE_DIR/ffind/ffind"
	create_link_for "$HOME/bin/cli-bookmarks" "$CODE_DIR/cli-bookmarks"
	echo done installing bin!
}

function install_nvim() {
	sudo apt-get install python3-pip
	sudo apt-get install python-pip
	sudo apt-get install xclip
	python3 -m pip install --user --upgrade pynvim
	python2 -m pip install --user --upgrade pynvim
	mkdir -p $HOME/opt/bin
	cd $HOME/opt/
	curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
	chmod u+x nvim.appimage
	cd $HOME/opt/bin
	create_link_for "$HOME/opt/bin/nvim" "$HOME/opt/nvim.appimage"
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	$HOME/opt/bin/nvim +PlugInstall
	echo done installing nvim!
}

function install_fzf() {
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	cd ~/.fzf
	git pull
	~/.fzf/install
}

# Installs to ~/go/bin
function install_go_utils() {
	go install arp242.net/uni
	go install golang.org/x/tools/gopls
}

main "$@"
