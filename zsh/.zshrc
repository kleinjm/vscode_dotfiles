##############################################################################
# File: zshrc
# Description: ZSH configuration used with oh-my-zsh
# Author: James Klein
##############################################################################

export ZSH=$HOME/.oh-my-zsh # Path to your oh-my-zsh installation.
export DOTFILES_DIR=$HOME/vscode_dotfiles
export PRIVATE_CONFIGS_DIR=$HOME/GitHubRepos/environment_configurations

# See https://stackoverflow.com/a/49462622/2418828
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE="true"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="jamesklein"

# make _ and - interchangeable
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# ignore insecure completion-dependent directories
ZSH_DISABLE_COMPFIX=true

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

HISTSIZE=1000000 # amount of commands saved in history

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# NOTE: zsh-syntax-highlighting was affecting boot performance
# NOTE: rails plugin temporarily removed because `rg` shortcut messed
# with ripgrep
plugins=(docker-compose git bundler rake ruby docker command-not-found colored-man-pages)

# manually trigger autosuggestions
AUTOSUGGESTIONS_DIR=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [ -d "$AUTOSUGGESTIONS_DIR" ]; then
  source $AUTOSUGGESTIONS_DIR/zsh-autosuggestions.zsh
fi

# See https://github.com/zsh-users/zsh-autosuggestions#usage
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20 # turn off autosuggest for large paste
export ZSH_AUTOSUGGEST_USE_ASYNC=1 # do autosuggest async

# Git
# use the default merge message so that EDITOR does not open
export GIT_MERGE_AUTOEDIT=no

# Load all .zsh config files in this dir
# NOTE: must come after oh-my-zsh.sh is sourced
for file in $HOME/*.zsh; do
  source "$file"
done