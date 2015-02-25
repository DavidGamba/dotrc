#!/bin/bash

function usage()
{
  option=$1
  if [[ -n "$option" ]]; then
    cat <<EOL
Invalid argument: '$option'

EOL
  fi
  cat <<EOL
    install -h|--help

    install [--bin]
EOL
}

function main()
{
  while test $# -gt 0 ; do
    case "$1" in
      -h|--help)
        usage
        exit 1
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
      -*)
        usage $1
        exit 1
      ;;
    esac
  done
  echo installing dotrc...
  install_dotrc
  exit 0
}

function create_link_for()
{
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

function install_dotrc()
{
  create_link_for "$HOME/.bashrc"     "dotrc/bashrc"
  create_link_for "$HOME/.nvimrc"     "dotrc/nvimrc"
  create_link_for "$HOME/.screenrc"   "dotrc/screenrc"
  create_link_for "$HOME/.perltidyrc" "dotrc/perltidyrc"
  create_link_for "$HOME/.inputrc"    "dotrc/inputrc"
  create_link_for "$HOME/.gitignore"  "dotrc/gitignore"
  create_link_for "$HOME/.hgrc"       "dotrc/hgrc"

  cp -n $HOME/dotrc/gitconfig $HOME/.gitconfig

  mkdir $HOME/opt
  mkdir $HOME/mnt
  mkdir -p $HOME/code/personal
  echo done installing dotrc!
}

function install_bin()
{
  if [[ ! -d $HOME/bin ]]; then
    set -x
    git clone git@github.com:DavidGamba/bin.git $HOME/bin
    set +x
  fi
  if [[ ! -d $HOME/code/personal/git ]]; then
    set -x
    mkdir $HOME/code/personal/git
    set +x
  fi
  if [[ ! -d $HOME/code/personal/git/grepp ]]; then
    git clone git@github.com:DavidGamba/grepp.git $HOME/code/personal/git/grepp
  fi
  if [[ ! -d $HOME/code/personal/git/ffind ]]; then
    git clone git@github.com:DavidGamba/ffind.git  $HOME/code/personal/git/ffind
  fi
  create_link_for "$HOME/bin/grepp" "$HOME/code/personal/git/grepp"
  create_link_for "$HOME/bin/ffind" "$HOME/code/personal/git/ffind"
  echo done installing bin!
}

function install_nvim()
{
  if [[ ! -d $HOME/opt/neovim ]]; then
    set -x
    git clone --depth 1 https://github.com/neovim/neovim.git
    make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX:PATH=$HOME/opt/neovim" install
    sudo pip install neovim
    create_link_for "$HOME/opt/bin/nvim" "$HOME/opt/neovim/bin/nvim"
    curl -fLo ~/.nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    $HOME/opt/bin/nvim +PlugInstall
    set +x
  fi
  echo done installing nvim!
}

main "$@"
