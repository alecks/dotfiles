#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set "$NAME" "label.color=$SPACE_SELECTED" "background.color=$SPACE_SELECTED_BACKGROUND"
else
    sketchybar --set "$NAME" "label.color=$SPACE" "background.color=$SPACE_BACKGROUND"
fi
