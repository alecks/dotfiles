export LANG=en_GB.utf8
export PATH="$HOME/.local/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"

# if USE_NIX is set AND IN_NIX isn't already set AND we have access to with-nix,
# use nix-user-chroot.
if [[ -n "$USE_NIX" && -z  "$IN_NIX" && -e "$HOME/.local/bin/with-nix" ]]; then
  export IN_NIX=1
  with-nix exec ~/.login
fi

exec ~/.login

