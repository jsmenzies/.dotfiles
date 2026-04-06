ZSH_DOTFILES_DIR="${${(%):-%N}:A:h}"

[[ -f "$ZSH_DOTFILES_DIR/shared.zprofile" ]] && source "$ZSH_DOTFILES_DIR/shared.zprofile"

case "$OSTYPE" in
  darwin*)
    [[ -f "$ZSH_DOTFILES_DIR/platform/mac.zprofile" ]] && source "$ZSH_DOTFILES_DIR/platform/mac.zprofile"
    ;;
  linux*)
    [[ -f "$ZSH_DOTFILES_DIR/platform/linux.zprofile" ]] && source "$ZSH_DOTFILES_DIR/platform/linux.zprofile"
    ;;
esac
