#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

volume=(
  "label.color=$VOLUME"
  background.color="$VOLUME_BACKGROUND"

  update_freq=120
  script="$PLUGIN_DIR/volume.sh"
)

sketchybar --add item volume right \
           --set volume "${volume[@]}" \
           --subscribe volume volume_change
