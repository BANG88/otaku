#!/usr/bin/env zsh

# Save current directory
CURRENT_DIR=$(pwd)

# Go to home directory
cd $HOME

# Generate config file
#bunx biome init

# Go back to original directory
cd "$CURRENT_DIR"

# Install lefthook
go install github.com/evilmartians/lefthook@latest

# fnm install node@20
fnm install 20
fnm default 20
fnm use 20
# Check if bun is installed
if ! command -v bun &>/dev/null; then
	echo "Installing bun..."
	curl -fsSL https://bun.sh/install | bash
fi

# Check if rust is installed
if ! command -v rustup &>/dev/null; then
	echo "Installing rust..."
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# zsh
source ~/.zshrc

# mkdir
if [ ! -d ~/personal ]; then
	mkdir -p ~/personal
fi

if [ ! -d ~/projects ]; then
	mkdir -p ~/projects
fi

# install global npm packages

npm install -g aicommit2
# usage: aicommit2 config set OPENAI.key=xxx
