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
elif [[ "$(hostname)" == "pleemcentre" ]]; then
  # Fedora PC
  export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/keyring/ssh  
  alias bw="flatpak run --command=bw com.bitwarden.desktop"
  . "$HOME/.cargo/env"

  # similar to macOS open -- just xdg-open and disown
  open() { xdg-open "$1" > /dev/null 2>&1 & disown }
else
  # Mac
  export PATH=$PATH:$(go env GOPATH)/bin
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
  export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"
fi

export OLLAMA_HOST="http://localhost:11434"
export PATH="$HOME/.local/bin:$PATH"
export UID=$(id -u)
export GID=$(id -g)

alias ls='ls --color=auto'
alias hxf='hx $(fzf)'

autoload -Uz compinit && compinit -C

# initialise fzf, surpress error if unavailable
eval "$(fzf --zsh 2>/dev/null || echo '')"

if command -v zoxide &>/dev/null; then
  # only initialise and alias z if it is available
  # note: must be done after compinit
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

eval "$(starship init zsh 2>/dev/null || echo '')"
