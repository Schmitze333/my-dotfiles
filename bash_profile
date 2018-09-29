# Colorize shell
export CLICOLOR=1

# Bash git completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
GIT_PS1_SHOWDIRTYSTATE=true

# Bash git prompt
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
    source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi

# Remind me to make local services accessable to docker containers
echo '===== Moin, moin! ========================================='
echo '===== Do NOT forget to run:   ============================='
echo '=====        sudo ifconfig lo0 alias 192.168.100.1 ========'
echo '==========================================================='

# Shell Shortcuts
alias ll='ls -lsa'

# bundle
alias be='bundle exec'

# Git Shortcuts
alias g='git status'
alias gl='git log'
alias gla='git log --all --graph --decorate'
alias glo='git log --all --graph --decorate --oneline'
alias gb='git branch'
alias gbr='git branch -rv'
alias gd='git diff'
alias gcv='git commit -v'
alias gf='git fetch'

# Always use NeoVim
alias nv='nvim'
alias vi='nvim'

# Spacemacs start editor in current directory
# alias spc='emacs . &'

# RBenv
eval "$(rbenv init -)"
