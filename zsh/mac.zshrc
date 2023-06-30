# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

export ZSH="/Users/james/.oh-my-zsh"

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    brew
    z
)

source $ZSH/oh-my-zsh.sh


alias upgrade='brew upgrade && omz update && rustup update && sdk update'

export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(github-copilot-cli alias -- "$0")"

[[ -f $HOME/.dotfiles/zsh/aliases.zsh ]] && source $HOME/.dotfiles/zsh/aliases.zsh
[[ -f $HOME/.dotfiles/zsh/functions.zsh ]] && source $HOME/.dotfiles/zsh/functions.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

eval "$(starship init zsh)"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

