#!/usr/bin/env bash

# Setup:
#   $ mkdir -p ~/.ssh
#   $ curl https://github.com/DavidGamba.keys | tee -a ~/.ssh/authorized_keys
#   $ sudo apt install openssh-server
#   Copy private key: 
#   $ scp ~/.ssh/id_rsa david@<host>:~/.ssh/
#   Back to new machine:
#   $ git clone git@github.com:DavidGamba/dotrc.git
#   $ cd dotrc; ./bootstrap.sh

function error() {
	>&2 echo $@
}

function install_go() {
	local version=$1
	shift
	mkdir -p ~/opt/bin/

	if [[ $(uname) =~ "Darwin" ]]; then
		error "Running on MacOS, install go manually before continuing"
		exit 1
	fi

	wget https://dl.google.com/go/go${version}.linux-amd64.tar.gz -P ~/opt/
	cd ~/opt
	tar -xvzf go${version}.linux-amd64.tar.gz
	ln -sf ~/opt/go/bin/go ~/opt/bin/go
	ln -sf ~/opt/go/bin/gofmt ~/opt/bin/gofmt
}

install_go "1.18.1"
cd ~/dotrc
~/opt/bin/go build -o build
