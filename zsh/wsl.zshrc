zmodload zsh/zprof

setopt HIST_IGNORE_ALL_DUPS

export STARSHIP_CONFIG="$HOME/.dotfiles/starship/starship.toml"
export ZSH="$HOME/.oh-my-zsh"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
)

source "$ZSH/oh-my-zsh.sh"

# Initialize zoxide (better z) - stores data in $XDG_DATA_HOME/zoxide
eval "$(zoxide init zsh)"

alias reload='source ~/.zshrc'
alias bat='batcat'

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -f ~/.dotfiles/zsh/aliases.zsh ]] && source ~/.dotfiles/zsh/aliases.zsh
[[ -f ~/.dotfiles/zsh/functions.zsh ]] && source ~/.dotfiles/zsh/functions.zsh
