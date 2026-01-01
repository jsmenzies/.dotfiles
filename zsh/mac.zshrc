export ZSH="/Users/james/.oh-my-zsh"
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    brew
    z
)

source $ZSH/oh-my-zsh.sh

alias upgrade='brew upgrade && omz update && rustup update'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -f $HOME/.dotfiles/zsh/aliases.zsh ]] && source $HOME/.dotfiles/zsh/aliases.zsh
[[ -f $HOME/.dotfiles/zsh/functions.zsh ]] && source $HOME/.dotfiles/zsh/functions.zsh

# yolo command which does git add . && git commit -m "vibing" && git push for the current branch even if it doesn't exist
alias yolo='git add . && git commit -m "vibing" && git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'

eval "$(starship init zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
eval "$(/opt/homebrew/bin/mise activate zsh)"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"
