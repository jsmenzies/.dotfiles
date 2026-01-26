# Colormap
function colourmap() {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

showenv() {
  printenv | sort
}

showpath() {
  print -rl -- ${(s/:/)PATH}
}

# Lazy load mise
mise() {
  unfunction mise
  eval "$(/opt/homebrew/bin/mise activate zsh)"
  mise "$@"
}