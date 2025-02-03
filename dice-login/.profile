export PATH="$HOME/.local/bin:$PATH"
if [[ -z  "$IN_NIX" && -e "$HOME/.local/bin/with-nix" ]]; then
  export IN_NIX=1
  echo "Attempting to start with-nix."
  exec with-nix ~/.login
fi
exec ~/.login

