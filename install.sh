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
  if [[ ! -e "$HOME/.$link" && ! -L "$HOME/.$link" ]]; then
    echo "creating link '.$link'"
    set -x
    ln -s $HOME/dotrc/$link $HOME/.$link
    set +x
  else
    if [[ `readlink "$HOME/.$link"` != "$HOME/dotrc/$link" ]]; then
      set -x
      readlink $HOME/.$link
      rm $HOME/.$link
      set +x
      if [[ $? -eq 0 ]]; then
        create_link_for $link
      else
        return 1
      fi
    fi
  fi
}

function install_dotrc()
{
  create_link_for 'bashrc'
  create_link_for 'vimrc'
  create_link_for 'vim'
  create_link_for 'screenrc'
  create_link_for 'perltidyrc'
  create_link_for 'inputrc'

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
    git clone https://github.com/DavidGamba/grepp.git $HOME/bin/external/grepp
    ln -s $HOME/bin/external/grepp/grepp $HOME/bin/grepp
    git clone https://github.com/DavidGamba/todo.git $HOME/bin/external/todo
    ln -s $HOME/bin/external/todo/todo $HOME/bin/todo
    set +x
  fi
  echo done installing bin!
}

main "$@"
