#!/usr/bin/env bash

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"
  if [ "$VOLUME" == 0 ]; then
    VOLUME="muted"
  fi
  sketchybar --set "$NAME" label="AUX $VOLUME%"
fi

