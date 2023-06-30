setopt HIST_IGNORE_ALL_DUPS

export STARSHIP_CONFIG="$HOME/.dotfiles/starship/starship.toml"
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/share/fnm:$PATH"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
    zsh-history-substring-search
)

source "$ZSH/oh-my-zsh.sh"

alias activate='source ~/.virtualenvs/wealth-xplan-update-publisher/bin/activate'
alias reload='source ~/.zshrc'
alias bat='batcat'

eval "$(github-copilot-cli alias -- "$0")"

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -f ~/.dotfiles/zsh/aliases.zsh ]] && source ~/.dotfiles/zsh/aliases.zsh
[[ -f ~/.dotfiles/zsh/functions.zsh ]] && source ~/.dotfiles/zsh/functions.zsh

# fnm
export PATH="/home/jsm/.local/share/fnm:$PATH"
eval "`fnm env`"
