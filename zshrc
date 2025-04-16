# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git asdf docker-compose emacs gpg-agent)

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# source $ZSH/oh-my-zsh.sh

### Using sheldon as plugin manager ###
eval "$(sheldon source)"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
alias be="bundle exec"
alias ber="bundle exec rake"

# Do not track Pact usage data from my machine!
export PACT_DO_NOT_TRACK="true"

# Clone ivx repositories
clown () { git clone git@github.com:ivx/"$@".git }
clownd () { git clone git@github.com:ivx/"$@".git && git clone git@github.com:ivx/"$@"-deploy.git }

# export AWS_ACCESS_KEY_ID=`awk -F "=" '/aws_access_key_id/ {print $2}' ${HOME}/.aws/credentials |tail -1 | xargs`
# export AWS_SECRET_ACCESS_KEY=`awk -F "=" '/aws_secret_access_key/ {print $2}' ${HOME}/.aws/credentials |tail -1 | xargs`
# export AWS_SESSION_TOKEN=`awk -F "=" '/aws_session_token/ {print $2}' ${HOME}/.aws/credentials |tail -1 | xargs`
# export AWS_REGION=`awk -F "=" '/region/ {print $2}' ${HOME}/.aws/config | tail -1 | xargs`
# export AWS_DEFAULT_REGION=`awk -F "=" '/region/ {print $2}' ${HOME}/.aws/config | tail -1 | xargs`
export GPG_TTY=$(tty)

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
[[ -f ~/.alias.local ]] && source ~/.alias.local

. /opt/homebrew/opt/asdf/libexec/asdf.sh
export PATH="/opt/homebrew/opt/gnupg@2.2/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
