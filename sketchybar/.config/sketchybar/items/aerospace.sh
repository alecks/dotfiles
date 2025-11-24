#!/usr/bin/env bash

sketchybar --add event aerospace_workspace_change

# TODO: Make this the same format as the rest of the items.
for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        background.color="$SPACE_BACKGROUND" \
        label="$sid" \
        label.color="$SPACE" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done
