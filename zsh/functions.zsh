source ~/.authenticate/authenticate.sh

export OKTA_USERNAME=james.menzies
export OKTA_MFA_OPTION=google
export OKTA_PASSWORD_HELPER='op item get "IRESS - SSO" --fields password'
export OKTA_TOTP_HELPER='op item get "IRESS - SSO" --otp'
# export AUTHENTICATE_CACHE_DIR=~/.authenticate/cache/
# export AUTHENTICATE_CACHE_MIN_TTL=43200

# IRESS Login
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
  export AWSU_PROFILE=$OKTA_AWS_ACCOUNT_NAME
}

# Colormap
function colourmap() {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}