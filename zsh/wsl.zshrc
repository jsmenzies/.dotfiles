zmodload zsh/zprof

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

alias reload='source ~/.zshrc'
alias bat='batcat'
alias op='op.exe'

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -f ~/.dotfiles/zsh/aliases.zsh ]] && source ~/.dotfiles/zsh/aliases.zsh
[[ -f ~/.dotfiles/zsh/functions.zsh ]] && source ~/.dotfiles/zsh/functions.zsh

# fnm
eval "$(fnm env --use-on-cd)"

eval "$(rbenv init -)"

# pnpm
export PNPM_HOME="/home/jsm/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/home/jsm/.bun/_bun" ] && source "/home/jsm/.bun/_bun"

eval "$(github-copilot-cli alias -- "$0")"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"