setopt HIST_IGNORE_ALL_DUPS

export STARSHIP_CONFIG="$HOME/.dotfiles/starship/starship.toml"
export ZSH="$HOME/.oh-my-zsh"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
    zsh-history-substring-search
)

source "$ZSH/oh-my-zsh.sh"

alias reload='source ~/.zshrc'
alias bat='batcat'

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -f ~/.dotfiles/zsh/aliases.zsh ]] && source ~/.dotfiles/zsh/aliases.zsh
[[ -f ~/.dotfiles/zsh/functions.zsh ]] && source ~/.dotfiles/zsh/functions.zsh
