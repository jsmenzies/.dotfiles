export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Initialize antidote plugin manager
ANTIDOTE_PATH=""
if command -v brew >/dev/null 2>&1; then
  ANTIDOTE_PATH="$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh"
elif [[ -f "/usr/share/antidote/antidote.zsh" ]]; then
  ANTIDOTE_PATH="/usr/share/antidote/antidote.zsh"
elif [[ -f "/usr/local/share/antidote/antidote.zsh" ]]; then
  ANTIDOTE_PATH="/usr/local/share/antidote/antidote.zsh"
elif [[ -f "$XDG_DATA_HOME/antidote/antidote.zsh" ]]; then
  ANTIDOTE_PATH="$XDG_DATA_HOME/antidote/antidote.zsh"
elif [[ -f "$HOME/.local/share/antidote/antidote.zsh" ]]; then
  ANTIDOTE_PATH="$HOME/.local/share/antidote/antidote.zsh"
fi

if [[ -n "$ANTIDOTE_PATH" && -f "$ANTIDOTE_PATH" ]]; then
  source "$ANTIDOTE_PATH"
  antidote load
fi

alias upgrade='brew upgrade && antidote update && rustup update'

if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

[[ -f $ZDOTDIR/aliases.zsh ]] && source $ZDOTDIR/aliases.zsh
[[ -f $ZDOTDIR/functions.zsh ]] && source $ZDOTDIR/functions.zsh

eval "$(starship init zsh)"
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# Bind arrow keys for history substring search
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

export PATH="$HOME/.local/bin:$PATH"

autoload -U compinit && compinit
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
if command -v carapace >/dev/null 2>&1; then
  source <(carapace _carapace)
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if [[ -f "$HOME/.local/share/../bin/env" ]]; then
  . "$HOME/.local/share/../bin/env"
fi
