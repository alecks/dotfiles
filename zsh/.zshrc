if [[ "$(hostname)" == *ed.ac.uk* ]]; then
  # We're on a uni machine.

  export PATH="$HOME/.local/bin:$PATH"
  # If we haven't already asked to enter nix, ask.
  if [[ -z "$DONE_NIX_CHECK" ]]; then
    exec enter-nix zsh "$@"
  fi

  if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    # If we have access to nix-profile, set up nix environment.
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  fi

  echo "Welcome back to ${$(hostname)%%.*}."
else
  # Personal
  export PATH=$PATH:$(go env GOPATH)/bin
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

  [ -f "/Users/alex/.ghcup/env" ] && . "/Users/alex/.ghcup/env" # ghcup-env

  # BEGIN opam configuration
  # This is useful if you're using opam as it adds:
  #   - the correct directories to the PATH
  #   - auto-completion for the opam binary
  # This section can be safely removed at any time if needed.
  [[ ! -r '/Users/alex/.opam/opam-init/init.zsh' ]] || source '/Users/alex/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
  # END opam configuration
fi

autoload -Uz compinit && compinit
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/poimandres.omp.json)"
prompt_context(){}

# initialise fzf, surpress error if unavailable
eval "$(fzf --zsh 2>/dev/null || echo '')"

if command -v zoxide &>/dev/null; then
  # only initialise and alias z if it is available
  eval "$(zoxide init zsh)"
  alias cd="z"
fi
