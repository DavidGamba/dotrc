#!/bin/bash

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

echo done!
