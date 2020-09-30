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

	install --deps
	install --dotrc
	install --go <version>
	install --bin
	install --utils
	install --nvim
	install --awscli
EOL
}

function main() {
	while test $# -gt 0 ; do
		case "$1" in
			-h|--help)
				usage
				exit 1
				;;
			--deps)
				install_deps
				exit 0
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
			--go)
				shift
				version=$1
				shift
				echo installing golang...
				install_go $version
				exit 0
				;;
			--awscli)
				shift
				install_awscli
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

function install_deps() {
	release=$(lsb_release -r -s)
	if [[ $release == "20.04" ]]; then
		sudo apt-get update && \
		sudo apt-get install \
			python3-pip \
			cargo \
			unzip
	fi
	if ! uname -r | grep -q microsoft; then
		sudo apt-get install xclip
	fi
	cargo install diffr
	cargo install ripgrep
	cargo install tealdeer
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
	create_link_for "$HOME/.config/nvim" "$HOME/dotrc/nvim"

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
	clone_repo git@github.com:DavidGamba/dgtools.git $CODE_DIR/dgtools
	clone_repo git@github.com:DavidGamba/go-wardley.git $CODE_DIR/go-wardley

	create_link_for "$HOME/bin/wardley" "$CODE_DIR/go-wardley/go-wardley"
	cd "$CODE_DIR/go-wardley/" && go build

	create_link_for "$HOME/bin/grepp" "$CODE_DIR/dgtools/grepp/grepp"
	cd "$CODE_DIR/dgtools/grepp/" && go build

	create_link_for "$HOME/bin/ffind" "$CODE_DIR/dgtools/ffind/ffind"
	cd "$CODE_DIR/dgtools/ffind/" && go build

	create_link_for "$HOME/bin/cli-bookmarks" "$CODE_DIR/dgtools/cli-bookmarks/cli-bookmarks"
	cd "$CODE_DIR/dgtools/cli-bookmarks/" && go build

	create_link_for "$HOME/bin/cssh" "$CODE_DIR/dgtools/cssh/cssh/cssh"
	cd "$CODE_DIR/dgtools/cssh/cssh/" && go build

	create_link_for "$HOME/bin/cscp" "$CODE_DIR/dgtools/cssh/cscp/cscp"
	cd "$CODE_DIR/dgtools/cssh/cscp/" && go build

	create_link_for "$HOME/bin/joinlines" "$CODE_DIR/dgtools/joinlines/joinlines"
	cd "$CODE_DIR/dgtools/joinlines/" && go build

	echo done installing bin!
}

function install_nvim() {
	echo "Install python dependencies at user level"
	python3 -m pip install --user --upgrade pynvim
	python2 -m pip install --user --upgrade pynvim
	echo "Download app image"
	mkdir -p $HOME/opt/bin
	cd $HOME/opt/
	curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
	chmod u+x nvim.appimage
	echo "Download app image update tool"
	wget https://github.com/AppImage/AppImageUpdate/releases/download/continuous/appimageupdatetool-x86_64.AppImage -O "$HOME/opt/bin/appimageupdatetool"
	chmod +x "$HOME/opt/bin/appimageupdatetool"
	echo "Update nvim"
	"$HOME/opt/bin/appimageupdatetool" "$HOME/opt/nvim.appimage"
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

function install_go() {
	local version=$1
	shift
	mkdir -p ~/opt/bin/
	wget https://dl.google.com/go/go${version}.linux-amd64.tar.gz -P ~/opt/
	cd ~/opt
	tar -xvzf go${version}.linux-amd64.tar.gz
	ln -sf ~/opt/go/bin/go ~/opt/bin/go
	ln -sf ~/opt/go/bin/gofmt ~/opt/bin/gofmt
}

# Installs to ~/go/bin
function install_go_utils() {
	set -x
	go get -u arp242.net/uni
	go install arp242.net/uni
	GO111MODULE=on go get -u golang.org/x/tools/gopls@master golang.org/x/tools@master
	go get -u golang.org/x/tools/godoc
	go install golang.org/x/tools/godoc
	set +x
}

function install_awscli() {
	mkdir -p ~/opt
	cd ~/opt
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	./aws/install --install-dir ~/opt/aws-cli --bin-dir ~/opt/bin
	rm aws/ -rf
}

main "$@"
