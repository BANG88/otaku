#!/usr/bin/env zsh

cd "$(dirname "${0:A}")"

git pull origin main

# Check if oh-my-zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	# Install oh-my-zsh without running zsh at the end
	RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
	echo "oh-my-zsh is already installed, skipping installation"
fi

function doIt() {
	local nvim_reply
	read "nvim_reply?Remove ~/.config/nvim directory? (y/n) "
	if [[ $nvim_reply =~ ^[Yy]$ ]]; then
		rm -rf ~/.config/nvim
	fi
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude ".macos" \
		--exclude "brew.sh" \
		--exclude "post.sh" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		--exclude "init/" \
		-avh --no-perms . ~

	# Check and create zsh config file if not exists
	if [ ! -f ~/.zshrc ]; then
		touch ~/.zshrc
	fi

	# Add .paths to .zshrc if not already included
	if ! grep -q "source ~/.paths" ~/.zshrc; then
		echo "source ~/.paths" >>~/.zshrc
		echo "Added .paths to .zshrc"
	fi

	source ~/.zshrc
}

if [[ "$1" == "--force" || "$1" == "-f" ]]; then
	doIt
else
	read "REPLY?This may overwrite existing files in your home directory. Are you sure? (y/n) "
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt
