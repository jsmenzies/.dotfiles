# Java & Gradle
#alias gcb='gradle clean build'
#alias use8='sdk use java 8.0.342-amzn'
#alias use11='sdk use java 11.0.16-amzn'
#alias use17='sdk use java 17.0.4-amzn'

# ls
alias l &>/dev/null && unalias l
alias l='eza --all --long --icons --color=auto --no-permissions --octal-permissions'

# yolo command which does git add . && git commit -m "vibing" && git push for the current branch even if it doesn't exist
alias yolo='git add . && git commit -m "vibing" && git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'

# Zsh
alias reload='source ~/.zshrc'