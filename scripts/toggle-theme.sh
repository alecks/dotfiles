#!/bin/bash

GHOSTTY_CONFIG="$HOME/dotfiles/ghostty/.config/ghostty/config"
HELIX_CONFIG="$HOME/dotfiles/helix/.config/helix/config.toml"
LIGHT_THEME="iceberg-light"
DARK_THEME="iceberg-dark"
DARK_MODE_ENABLED="false"

# Detect current mode by checking Ghostty's theme
if grep -q "theme = \"$LIGHT_THEME\"" "$GHOSTTY_CONFIG"; then
    # Switch to dark mode
    sed -i.bak "s/theme = \"$LIGHT_THEME\"/theme = \"$DARK_THEME\"/" "$GHOSTTY_CONFIG"
    sed -i.bak "s/theme = \"$LIGHT_THEME\"/theme = \"$DARK_THEME\"/" "$HELIX_CONFIG"
    DARK_MODE_ENABLED="true"
    echo "Switched to dark mode."
else
    sed -i.bak "s/theme = \"$DARK_THEME\"/theme = \"$LIGHT_THEME\"/" "$GHOSTTY_CONFIG"
    sed -i.bak "s/theme = \"$DARK_THEME\"/theme = \"$LIGHT_THEME\"/" "$HELIX_CONFIG"
    DARK_MODE_ENABLED="false"
    echo "Switched to light mode."
fi

if [[ "$(uname)" == "Darwin" ]]; then
    # most cursed and insane thing ever
    osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to $DARK_MODE_ENABLED"
fi

echo "Use the keybind cmd-shift-comma to reload Ghostty."
