#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

battery=(
  # label
  label.color="$BATTERY"
  background.color="$BATTERY_BACKGROUND"


  # functionality
  update_freq=120
  script="$PLUGIN_DIR/battery.sh"
)

sketchybar --add item battery right \
           --set battery "${battery[@]}" \
           --subscribe battery system_woke power_source_change
