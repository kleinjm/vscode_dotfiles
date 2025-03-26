#!/usr/bin/env bash

# create a directory for git templates if it doesn't exist
mkdir -p $HOME/.git_template

# Install oh-my-zsh if it doesn't exist
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "oh-my-zsh already installed. Continuing..."
fi

# Install stow
yes | sudo apt-get install stow

# v = verbose, t = target directory, d = current directory
rm -rf $HOME/.zshrc
rm -rf $HOME/.gitconfig
stow -v -t "$HOME" -d . zsh
stow -v -t "$HOME" -d . git

# Run install scripts after everything has been set up
./install_scripts/zsh_autosuggestions.sh
