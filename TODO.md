# Dotfiles TODO

Code review findings and improvements for the dotfiles repository.

## 🔴 Critical Issues

### 1. Inconsistent Configuration Between mac.zshrc and wsl.zshrc
- [ ] Sync profiling setup (WSL has it enabled, Mac doesn't)
- [ ] Add `HIST_IGNORE_ALL_DUPS` to mac.zshrc
- [ ] Decide on git plugin usage (removed from Mac for performance, still in WSL)
- [ ] Update WSL to use modern FZF: `source <(fzf --zsh)` instead of old method
- [ ] Add starship config export to both
- [ ] Add `reload` alias to mac.zshrc or remove from WSL

---

## ⚠️ Medium Priority

### 4. Missing README.md
- [ ] Create README with:
  - Prerequisites (Homebrew, oh-my-zsh, fzf, eza, starship, mise, zoxide)
  - Installation instructions
  - Features list
  - Performance notes (~110ms startup)

### 6. Missing XDG Compliance for Additional Tools
Add to `.zshenv`:
```zsh
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
```
- [ ] Add zsh history to XDG_STATE_HOME
- [ ] Add GPG home to XDG_DATA_HOME
- [ ] Add Docker config to XDG_CONFIG_HOME
- [ ] Add NPM config to XDG_CONFIG_HOME
- [ ] Add Node REPL history to XDG_DATA_HOME

### 7. Inconsistent Starship Config Location
- [ ] Add to `.zshenv`: `export STARSHIP_CONFIG="$HOME/.dotfiles/starship/starship.toml"`
- [ ] Ensure both Mac and WSL use this

### 8. Apply Performance Optimizations to WSL
- [ ] Add `ZSH_DISABLE_COMPFIX=true` to wsl.zshrc
- [ ] Consider removing heavy plugins like in Mac config
- [ ] Test WSL startup performance

---

## 💡 Low Priority Improvements

### 10. Install Script Enhancement
- [ ] Add dependency checking
- [ ] Add oh-my-zsh auto-install
- [ ] Add plugin installation (zsh-syntax-highlighting, zsh-autosuggestions)
- [ ] Add optional tool installation (fzf, eza, starship, zoxide)

### 11. Functions.zsh Enhancement
Consider using mise shims instead of lazy loading:
```zsh
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh --shims)"
fi
```
- [ ] Test mise shims approach vs current lazy loading

### 12. Path Management
- [ ] Move `export PATH="$HOME/.local/bin:$PATH"` to `.zshenv`
- [ ] Remove from `.zshrc` (should be in env file for all subshells)

### 13. Ghostty Config Cleanup
- [ ] Remove template comments (lines 1-50)
- [ ] Keep only actual configuration

### 14. Git Config Additions
Consider adding:
```ini
[pull]
    rebase = true

[fetch]
    prune = true

[diff]
    colorMoved = default

[merge]
    conflictstyle = zdiff3
```
- [ ] Add recommended git config options

### 15. SSH Auth Sock Safety
Make it conditional:
```zsh
if [[ -S "$HOME/.1password/agent.sock" ]]; then
    export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
fi
```
- [ ] Update mac.zshrc to check if 1Password agent exists

### 16. Aliases Organization
Consider splitting into categories:
```
zsh/aliases/
  common.zsh
  git.zsh
  navigation.zsh
```
- [ ] Decide if alias organization is worth it

### 17. Missing Zsh Options
Add to zshrc:
```zsh
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS
setopt CORRECT
```
- [ ] Add recommended zsh options

### 18. Additional Documentation
- [ ] Add LICENSE file if planning to share publicly
- [ ] Consider CHANGELOG.md to track changes over time
- [ ] Add comments explaining non-obvious configurations

### 19. Backup/Restore Script
- [ ] Create `backup.sh` to export current settings before major changes
- [ ] Consider versioning important configs

### 20. Tool Version Documentation
- [ ] Document versions of tools being used
- [ ] Consider using mise to manage tool versions in `.mise.toml`

---

## 📊 Performance Notes

Current startup time: **~110ms** (Mac)
- First run: ~400ms (rebuilding caches)
- Subsequent runs: ~110ms

Optimizations applied:
- Removed git/brew plugins (saved ~200ms)
- Disabled compfix (saved ~10-20ms)
- Fixed double compinit (saved ~150ms)
- Lazy-loaded mise (will save ~15ms when not needed)

---

## 🎯 Quick Wins (Do These First)

1. [ ] Remove duplicate `bold-color` in ghostty/config
2. [ ] Delete commented Java aliases
3. [ ] Update WSL FZF to modern syntax
4. [ ] Add README.md
5. [ ] Sync HIST_IGNORE_ALL_DUPS between Mac/WSL
6. [ ] Move PATH to .zshenv
7. [ ] Update .gitignore

---

## 📝 Notes

- Repository is well-organized and follows good practices
- XDG compliance is already mostly implemented
- Performance optimizations are working well on Mac
- Main issue is consistency between Mac and WSL configs
- No major security issues found
