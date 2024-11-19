#!/usr/bin/env zsh

# Save current directory
CURRENT_DIR=$(pwd)

# Go to home directory
cd $HOME

# Generate config file
bunx biome init

# Go back to original directory
cd "$CURRENT_DIR"

# Install lefthook
go install github.com/evilmartians/lefthook@latest

# fnm install node@20
fnm install 20
fnm default 20
fnm use 20

# zsh
source ~/.zshrc
