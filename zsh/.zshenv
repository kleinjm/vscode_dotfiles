# This file loads in non-interactive shells
# I've found that using this file slows down the shell, specifically
# vim-tmux navigation. Instead, favor zshrc.

# Load all .zshenv config files in this dir
# aliases.zshenv should be available in all shells, not just interactive ones.
# Ie. vim should have aliases

export ZSH=$HOME/.oh-my-zsh # Path to your oh-my-zsh installation.
export DOTFILES_DIR=$HOME/vscode_dotfiles
export PRIVATE_CONFIGS_DIR=$HOME/GitHubRepos/environment_configurations

# See https://stackoverflow.com/a/49462622/2418828
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE="true"

for file in $DOTFILES_DIR/zsh/*.zshenv; do
  source "$file"
done
