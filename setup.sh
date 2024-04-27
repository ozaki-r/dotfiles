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

# fish
mkdir -p $HOME/.config/fish/functions/
base=".config/fish/"
for file in $base/config.fish $base/functions/fish_prompt.fish; do
	target=$HOME/$file
	if [ -f $target ]; then
		echo "warning: $target already exists"
	else
		cp $file $target
	fi
done

mkdir -p ~/bin

mkdir -p ~/.vim/colors
curl https://raw.githubusercontent.com/gosukiwi/vim-atom-dark/master/colors/atom-dark-256.vim > ~/.vim/colors/atom-dark-256.vim

# ref. https://www.tomica.net/blog/2016/10/ssh-agent-service-in-fedora/
mkdir -p $HOME/.config/systemd/user/
cat > $HOME/.config/systemd/user/ssh-agent.service <<EOF
[Unit]
Description=SSH key agent
[Service]
Type=forking
Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
ExecStart=/usr/bin/ssh-agent -a \$SSH_AUTH_SOCK
[Install]
WantedBy=default.target
EOF
systemctl --user enable --now ssh-agent.service
