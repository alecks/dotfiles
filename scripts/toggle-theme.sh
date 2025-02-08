#!/bin/bash

GHOSTTY_CONFIG="$HOME/dotfiles/ghostty/.config/ghostty/config"
HELIX_CONFIG="$HOME/dotfiles/helix/.config/helix/config.toml"

# Detect current mode by checking Ghostty's theme
if grep -q 'theme = "GruvboxLight"' "$GHOSTTY_CONFIG"; then
    # Switch to dark mode
    sed -i.bak 's/theme = "GruvboxLight"/theme = "tokyonight"/' "$GHOSTTY_CONFIG"
    sed -i.bak 's/theme = "gruvbox_light_soft"/theme = "poimandres"/' "$HELIX_CONFIG"
    echo "Switched to dark mode."
else
    sed -i.bak 's/theme = "tokyonight"/theme = "GruvboxLight"/' "$GHOSTTY_CONFIG"
    sed -i.bak 's/theme = "poimandres"/theme = "gruvbox_light_soft"/' "$HELIX_CONFIG"
    echo "Switched to light mode."
fi
