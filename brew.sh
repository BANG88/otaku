#!/usr/bin/env zsh

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add Homebrew to PATH
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
source ~/.zshrc
# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed

# Install `wget` with IRI support.
brew install wget

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim
brew install grep
brew install openssh
brew install screen

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install other useful binaries.
brew install ack
brew install gs
brew install imagemagick
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rlwrap
brew install ssh-copy-id
brew install tree
brew install unzip

# Install development tools and utilities
brew install automake
brew install bat
brew install cloudflared
brew install cmake
brew install biome
brew install cocoapods
brew install coreutils
brew install curl
brew install facebook/fb/idb-companion
brew install fd
brew install ffmpeg
brew install fnm
brew install fsouza/prettierd/prettierd
brew install fzf
brew install gh
brew install git
brew install git-filter-repo
brew install git-lfs
brew install git-town
brew install go
brew install graphviz
brew install jq
brew install lazygit
brew install llvm
brew install luarocks
brew install maven
brew install ncmdump
brew install neovim
brew install openssl
brew install perl
brew install pgloader
brew install pnpm
brew install protobuf
brew install python@3.10
brew install rbenv
brew install ripgrep
brew install sevenzip
brew install the_silver_searcher
brew install tmux
brew install universal-ctags
brew install vips
brew install virtualenv
brew install watchman
brew install wget
brew install wrk
brew install yarn
brew install zbar
brew install zlib
brew install zsh
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

# font lists

fonts_list=(
  font-d2coding-nerd-font
  font-hack-nerd-font
  font-noto-nerd-font
  font-symbols-only-nerd-font
  font-ubuntu-nerd-font
)

for font in "${fonts_list[@]}"; do
  brew install --cask "$font"
done

# casks

# Install cask applications
casks_list=(
  android-studio
  another-redis-desktop-manager
  bitwarden
  bruno
  cursor
  docker
  figma
  git-credential-manager
  google-chrome
  iina
  iterm2
  localsend
  lyricsx
  macfuse
  neteasemusic
  obs
  onedrive
  quickrecorder
  rectangle
  royal-tsx
  sequel-ace
  snipaste
  telegram
  the-unarchiver
  xcodes
  zed
  zulu@17
  visual-studio-code
)

# Install cask applications
echo "Starting Cask applications installation..."
for cask in "${casks_list[@]}"; do
  echo "Installing $cask..."
  brew install --cask "$cask"
done

# Remove outdated versions from the cellar.
brew cleanup

source post.sh
