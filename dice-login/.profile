export PATH="$HOME/.local/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"

# TODO: reinstate if I choose to use nix again
# if [[ -z  "$IN_NIX" && -e "$HOME/.local/bin/with-nix" ]]; then
#   export IN_NIX=1
#   exec ~/.login
# fi

exec ~/.login

