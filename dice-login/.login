#!/bin/bash

# Source nix.sh if available
if [[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# If we're graphical, start i3.
# Otherwise, bash will be started, which invokes zsh from .brc.
if [[ -n "$DISPLAY" ]]; then
    exec i3
fi

