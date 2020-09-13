#!/bin/sh

for file in .gitconfig .tmux.conf .vimrc .zshrc; do
	target=$HOME/$file
	if [ -f $target ]; then
		echo "warning: $target already exists"
	else
		cp $file $target
	fi
done
for dir in .tmux; do
	target=$HOME/$dir
	if [ -d $target ]; then
		echo "warning: $target already exists"
	else
		cp -r $dir $HOME
	fi
done

mkdir -p ~/bin

mkdir -p ~/.vim/colors
curl https://raw.githubusercontent.com/gosukiwi/vim-atom-dark/master/colors/atom-dark-256.vim > ~/.vim/colors/atom-dark-256.vim
