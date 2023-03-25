# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/Users/james/.oh-my-zsh"

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    brew
    z
)

source $ZSH/oh-my-zsh.sh

alias gcb='gradle clean build'
alias use8='sdk use java 8.0.342-amzn'
alias use11='sdk use java 11.0.16-amzn'
alias use17='sdk use java 17.0.4-amzn'
alias l='exa --all --long --icons --color=auto --no-permissions --octal-permissions'
alias activate='source ./venv/bin/activate'
alias reload='source ~/.zshrc'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
source ~/.authenticate/authenticate.sh

function auth () {
  if [[ "$1" == "st" ]]; then
    echo "Connecting to Staging AU"
    eval $(op signin)
    authenticate --to wealth-staging-au
  else
    echo "Connecting to Technet AU"
    eval $(op signin)
    authenticate
  fi
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export OKTA_PASSWORD_HELPER='op item get "IRESS - SSO" --fields password'
export OKTA_TOTP_HELPER='op item get "IRESS - SSO" --otp'
export OKTA_USERNAME=james.menzies
export OKTA_MFA_OPTION=google

eval "$(github-copilot-cli alias -- "$0")"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
