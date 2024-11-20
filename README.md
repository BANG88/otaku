# Otaku

> My personal dotfiles. Use at your own risk!

## Installation

> If you are on a new machine, you should check `git --version` at first. You may need to install developer tools.

### Using Git and the bootstrap script

You can clone the repository wherever you want.

```bash
git clone https://github.com/BANG88/otaku.git .otaku && cd .otaku && source bootstrap.sh
```

To update, `cd` into your local `otaku` repository and then:

```bash
set -- -f; source bootstrap.sh
```

To update later on, just run that command again.

### Add custom commands without creating a new fork

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/.extra` looks something like this:

```bash
# Git credentials
# Use your own name and email
GIT_AUTHOR_NAME="Ellen"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="ellen@puffin.studio"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

### Sensible macOS defaults

When setting up a new Mac, you may want to set some sensible macOS defaults:

```bash
./.macos
```

### Install Homebrew formulae

When setting up a new Mac, you may want to install some common [Homebrew](https://brew.sh/) formulae (after installing Homebrew, of course):

Please note that you may need to provide your password for installing some casks.

```bash
./brew.sh
```

Some of the functionality of these dotfiles depends on formulae installed by `brew.sh`. If you don’t plan to run `brew.sh`, you should look carefully through the script and manually install any particularly important ones. A good example is Bash/Git completion: the dotfiles use a special version from Homebrew.

### Apps

- https://github.com/openai-translator/openai-translator/releases
- https://apps.apple.com/us/app/encrypto-secure-your-files/id935235287?mt=12
- https://pinyin.sogou.com/mac/
