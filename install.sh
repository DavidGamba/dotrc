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
      --vim)
        shift
        echo installing vim...
        install_vim
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
  create_link_for "$HOME/.hgrc"       "dotrc/hgrc"

  cp -n $HOME/dotrc/gitconfig $HOME/.gitconfig

  if [[ ! -d $HOME/.vim/bundle/vundle ]]; then
    git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/Vundle.vim
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
  if [[ ! -d $HOME/code/personal/git ]]; then
    set -x
    mkdir $HOME/code/personal/git
    set +x
  fi
  if [[ ! -d $HOME/code/personal/git/grepp ]]; then
    git clone https://github.com/DavidGamba/grepp.git $HOME/code/personal/git/grepp
  fi
  if [[ ! -d $HOME/code/personal/git/todo ]]; then
    git clone https://github.com/DavidGamba/todo.git  $HOME/code/personal/git/todo
  fi
  if [[ ! -d $HOME/code/personal/git/ffind ]]; then
    git clone https://github.com/DavidGamba/ffind.git  $HOME/code/personal/git/ffind
  fi
  if [[ ! -d $HOME/code/personal/mercurial/vim ]]; then
    mkdir -p $HOME/code/personal/mercurial
    hg clone https://vim.googlecode.com/hg/ $HOME/code/personal/mercurial/vim
  fi
  create_link_for "$HOME/bin/grepp" "$HOME/code/personal/git/grepp"
  create_link_for "$HOME/bin/todo"  "$HOME/code/personal/git/todo"
  create_link_for "$HOME/bin/ffind" "$HOME/code/personal/git/ffind"
  echo done installing bin!
}

function install_vim()
{
  if [[ ! -d $HOME/code/personal/mercurial/vim ]]; then
    mkdir -p $HOME/code/personal/mercurial
    hg clone https://vim.googlecode.com/hg/ $HOME/code/personal/mercurial/vim
  fi
  cd $HOME/code/personal/mercurial/vim
  hg update default
  hg update -C
  cd src
  make distclean  # if you build Vim before
  ./configure --with-compiledby="David Gamba <davidgamba@gambaeng.com>" \
    --with-features=huge \
    --enable-gui=auto \
    --with-x \
    --enable-luainterp \
    --enable-rubyinterp \
    --with-ruby-command=/usr/bin/ruby \
    --enable-perlinterp \
    --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config \
    --enable-fontset \
    --enable-cscope \
    --enable-gtk2-check \
    --enable-gnome-check
  make
  sudo make install
  echo done installing vim!
}

main "$@"
