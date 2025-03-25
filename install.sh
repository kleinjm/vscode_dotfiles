#!/usr/bin/env bash

# create a directory for git templates if it doesn't exist
mkdir -p $HOME/.git_template

# clone the dotfiles repo into the git template directory only if it doesn't exist
if [ ! -d "$HOME/.dotfiles" ]; then
  git clone --bare git@github.com:kleinjm/vscode_dotfiles.git $HOME/.dotfiles
else
  echo "Dotfiles repo already exists. Continuing..."
fi

# define config alias locally since the dotfiles
# aren't installed on the system yet
function config {
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

# create a directory to backup existing dotfiles to if it doesn't exist
mkdir -p .dotfiles-backup

echo "Checking out dotfiles from git@github.com:kleinjm/vscode_dotfiles.git"
config checkout
echo "Done checking out dotfiles from git@github.com:kleinjm/vscode_dotfiles.git"
if [ $? = 0 ]; then
  echo "Checked out dotfiles from git@github.com:kleinjm/vscode_dotfiles.git";
  else
    echo "Moving existing dotfiles to ~/.dotfiles-backup";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi

# checkout dotfiles from repo
config checkout
config config status.showUntrackedFiles no
