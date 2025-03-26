#!/usr/bin/env bash

# create a directory for git templates if it doesn't exist
mkdir -p $HOME/.git_template

# clone the dotfiles repo into the git template directory only if it doesn't exist
if [ ! -d "$HOME/vscode_dotfiles" ]; then
  git clone --bare git@github.com:kleinjm/vscode_dotfiles.git $HOME/vscode_dotfiles
else
  echo "VS Code dotfiles repo already exists. Continuing..."
fi

# Install stow
yes | sudo apt-get install stow

# v = verbose, t = target directory, d = current directory
rm -rf $HOME/.zshrc
stow -v -t "$HOME" -d . zsh
stow -v -t "$HOME" -d . git

# Run install scripts after everything has been set up
./install_scripts/zsh_autosuggestions.sh
