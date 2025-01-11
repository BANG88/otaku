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
# taps
brew tap bramstein/webfonttools
brew tap facebook/fb
brew_list=(
	mise
  chafa
  moreutils
  findutils
  gnu-sed
  wget
  gnupg
  vim
  grep
  openssh
  screen
  sfnt2woff
  sfnt2woff-zopfli
  woff2
  ack
  gs
  imagemagick
  lua
  lynx
  p7zip
  pigz
  pv
  rename
  ssh-copy-id
  tree
  unzip
  rlwrap
  automake
  bat
  cloudflared
  cmake
  biome
  cocoapods
  coreutils
  curl
  idb-companion
  fd
  ffmpeg
  fnm
  fsouza/prettierd/prettierd
  fzf
  gh
  git
  git-filter-repo
  git-lfs
  git-town
  go
  graphviz
  jq
  lazygit
  llvm
  luarocks
  maven
  ncmdump
  neovim
  openssl
  perl
  pgloader
  pnpm
  protobuf
  python@3.10
  rbenv
  ripgrep
  sevenzip
  the_silver_searcher
  tmux
  universal-ctags
  vips
  virtualenv
  watchman
  wget
  wrk
  yarn
  zbar
  zlib
  zsh
  zsh-autosuggestions
  zsh-syntax-highlighting
	zsh-completions
  lihaoyun6/tap/quickrecorder
	bufbuild/buf/buf
	fastlane
)

for brew in "${brew_list[@]}"; do
  if ! brew list "$brew" &>/dev/null; then
    echo "Installing $brew..."
    brew install "$brew"
  else
    echo "$brew is already installed"
  fi
done

# font lists
fonts_list=(
  font-d2coding-nerd-font
  font-hack-nerd-font
  font-noto-nerd-font
  font-symbols-only-nerd-font
  font-ubuntu-nerd-font
)

for font in "${fonts_list[@]}"; do
  if ! brew list --cask "$font" &>/dev/null; then
    echo "Installing $font..."
    brew install --cask "$font"
  else
    echo "$font is already installed"
  fi
done

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
  neteasemusic
  obs
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
  wechat
  imageoptim
  firefox
  microsoft-office
  pgadmin4
  # tencent-meeting
  dotnet-sdk
	# futubull
	ghostty
)

# Install cask applications
echo "Starting Cask applications installation..."
for cask in "${casks_list[@]}"; do
  #   check if cask is already installed
  if ! brew list --cask "$cask" &>/dev/null; then
    echo "Installing $cask..."
    brew install --cask "$cask"
  else
    echo "$cask is already installed"
  fi
done

# Remove outdated versions from the cellar.
brew cleanup

source post.sh
