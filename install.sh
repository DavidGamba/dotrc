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
  create_link_for "$HOME/.vimrc"      "dotrc/vimrc"
  create_link_for "$HOME/.vim"        "dotrc/vim"
  create_link_for "$HOME/.screenrc"   "dotrc/screenrc"
  create_link_for "$HOME/.perltidyrc" "dotrc/perltidyrc"
  create_link_for "$HOME/.inputrc"    "dotrc/inputrc"
  create_link_for "$HOME/.gitignore"  "dotrc/gitignore"

  cp -n $HOME/dotrc/gitconfig $HOME/.gitconfig

  if [[ ! -d $HOME/.vim/bundle/vundle ]]; then
    git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
    vim +BundleInstall +qall
  fi
  echo done installing dotrc!
}

function install_bin()
{
  if [[ ! -d $HOME/bin ]]; then
    set -x
    git clone https://github.com/DavidGamba/bin.git $HOME/bin
    set +x
  fi
  if [[ ! -d $HOME/bin/external ]]; then
    set -x
    mkdir $HOME/bin/external
    set +x
  fi
  if [[ ! -d $HOME/bin/external/grepp ]]; then
    git clone https://github.com/DavidGamba/grepp.git $HOME/bin/external/grepp
  fi
  if [[ ! -d $HOME/bin/external/todo ]]; then
    git clone https://github.com/DavidGamba/todo.git  $HOME/bin/external/todo
  fi
  create_link_for "$HOME/bin/grepp" "external/grepp/grepp"
  create_link_for "$HOME/bin/todo"  "external/todo/todo"
  echo done installing bin!
}

main "$@"
