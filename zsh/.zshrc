export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Initialize antidote plugin manager
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load

alias upgrade='brew upgrade && antidote update && rustup update'

source <(fzf --zsh)

[[ -f $ZDOTDIR/aliases.zsh ]] && source $ZDOTDIR/aliases.zsh
[[ -f $ZDOTDIR/functions.zsh ]] && source $ZDOTDIR/functions.zsh

eval "$(starship init zsh)"

# Bind arrow keys for history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

export PATH="$HOME/.local/bin:$PATH"

eval "$(zoxide init zsh)"