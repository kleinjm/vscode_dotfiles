# Git aliases and functions
gprune() {
    git fetch --prune && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D
}
