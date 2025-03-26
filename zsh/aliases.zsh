# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes.
# For a full list of active aliases, run `alias`.
# Don't forget that zsh plugins like git include their own aliases

# shell commands
alias ls="ls -FGhla" # -F symbols, -G colorized output, -h full unit (Kilobyte)
alias cp="cp -iv" # -i will ask form confirmation when overwriting files
alias df="df -h" # disk free space
alias du="du -cksh" # disk usage
alias ls="ls -FGhla" # -F symbols, -G colorized output, -h full unit (Kilobyte)
alias mkdir="mkdir -v" # -v verobse
alias mv="mv -iv" # -i will ask confirmation before overwriting an existing dir
alias rm="rm -v" # -i will ask confirmation before deleting a file

# Use modern regexps for sed, ie. "(one|two)", not "\(one\|two\)"
alias sed="sed -E"

alias G="| grep " # ie. "rails routes G user" 

# Git
alias ga='git add'
alias gl='git log'
alias gs='git s'
alias main='git main'

# Rails
alias rT="bundle exec rake -T | grep " # search rake tasks
alias rake='noglob rake' # https://github.com/robbyrussell/oh-my-zsh/issues/433#issuecomment-1670663
alias rc!="spring stop && rails console"
alias update="main && gprune && bundle && yarn && spring stop && rails db:migrate && rails restart"