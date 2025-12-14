if [[ "$(hostname)" == *ed.ac.uk* ]]; then
  # We're on a uni machine.
  export BYPASS_NIX_CHECK_NORMAL=1
  # If we haven't already asked to enter nix, ask.
  if [[ -z "$DONE_NIX_CHECK" ]]; then
    exec enter-nix zsh "$@"
  fi

  if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    # If we have access to nix-profile, set up nix environment.
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  fi

  echo "Welcome back to $(hostname)."
elif [[ "$(hostname)" == "thinkpad" ]]; then
  # On ThinkPad/Arch.
  function y() {
  	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  	yazi "$@" --cwd-file="$tmp"
  	IFS= read -r -d '' cwd < "$tmp"
  	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  	rm -f -- "$tmp"
  }

  alias hx="helix"
else
  # Mac
  export PATH=$PATH:$(go env GOPATH)/bin
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
fi

export PATH="$HOME/.local/bin:$PATH"

autoload -Uz compinit && compinit -C

# initialise fzf, surpress error if unavailable
eval "$(fzf --zsh 2>/dev/null || echo '')"

if command -v zoxide &>/dev/null; then
  # only initialise and alias z if it is available
  # note: must be done after compinit
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

eval "$(starship init zsh)"
