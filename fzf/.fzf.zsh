# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/james/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/james/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/james/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/james/.fzf/shell/key-bindings.zsh"
