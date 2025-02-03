export PATH="$HOME/.local/bin:$PATH"

# TODO: reinstate if I choose to use nix again
# if [[ -z  "$IN_NIX" && -e "$HOME/.local/bin/with-nix" ]]; then
#   export IN_NIX=1
#   exec ~/.login
# fi

exec ~/.login

