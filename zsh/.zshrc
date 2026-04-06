ZSH_DOTFILES_DIR="${${(%):-%N}:A:h}"

case "$OSTYPE" in
  darwin*)
    [[ -f "$ZSH_DOTFILES_DIR/platform/mac.zshrc" ]] && source "$ZSH_DOTFILES_DIR/platform/mac.zshrc"
    ;;
  linux*)
    [[ -f "$ZSH_DOTFILES_DIR/platform/linux.zshrc" ]] && source "$ZSH_DOTFILES_DIR/platform/linux.zshrc"
    ;;
esac

[[ -f "$ZSH_DOTFILES_DIR/shared.zshrc" ]] && source "$ZSH_DOTFILES_DIR/shared.zshrc"
