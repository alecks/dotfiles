#!/bin/bash

# Catppuccin Mocha theme for sketchybar

# Base Colors
export BASE=0xff1e1e2e
export MANTLE=0xff181825 # Used for the main bar background
export CRUST=0xff11111b # Used for module backgrounds (darker)

# Text Colors
export TEXT=0xffcdd6f4
export SUBTEXT0=0xffa6adc8
export SUBTEXT1=0xffbac2de

# Accent Colors
export ROSEWATER=0xfff5e0dc
export FLAMINGO=0xfff2cdcd
export PINK=0xfff5c2e7
export MAUVE=0xffcba6f7
export RED=0xfff38ba8
export MAROON=0xffeba0ac
export PEACH=0xfffab387
export YELLOW=0xfff9e2af
export GREEN=0xffa6e3a1
export TEAL=0xff94e2d5
export SKY=0xff89dceb
export SAPPHIRE=0xff74c7ec
export BLUE=0xff89b4fa
export LAVENDER=0xffb4befe

# Your sketchybar variable mapping to Catppuccin Mocha
export RED=$RED           # Catppuccin Red for critical alerts
export YELLOW=$YELLOW         # Catppuccin Yellow for warnings
export ORANGE=$PEACH          # Catppuccin Peach for general accents (closest vibrant match)
export GREEN=$GREEN           # Catppuccin Green

# Module backgrounds - now opaque, using the CRUST color for distinction
export MODULE_BACKGROUND=$CRUST # Opaque darker background for modules

export GREEN_BG=$MODULE_BACKGROUND
export LAVENDER=$LAVENDER     # Catppuccin Lavender
export LAVENDER_BG=$MODULE_BACKGROUND
export FLAMINGO=$FLAMINGO     # Catppuccin Flamingo
export FLAMINGO_BG=$MODULE_BACKGROUND

export PINK=$PINK             # Catppuccin Pink
export PINK_BG=$MODULE_BACKGROUND

export OVERLAY1=$TEXT         # Catppuccin TEXT for primary text/foreground

# General bar colors - now opaque, using the MANTLE color
export BAR_COLOR=$MANTLE      # Opaque main bar background
export LABEL_COLOR=$TEXT      # Catppuccin TEXT for general labels
export POPUP_BACKGROUND_COLOR=$CRUST # Catppuccin CRUST for popup bg (consistent with modules)

# Items (Catppuccin colors on opaque module background)
export SPACE_SELECTED=$MAUVE  # Active space text color (Catppuccin Mauve)
export SPACE_SELECTED_BACKGROUND=$CRUST # Opaque module background for active space

export SPACE=$SUBTEXT1        # Unselected space text color (Catppuccin SUBTEXT1)
export SPACE_BACKGROUND=$MANTLE # Opaque darker background for unselected spaces

export CALENDAR=$LAVENDER
export CALENDAR_BACKGROUND=$MODULE_BACKGROUND

export BATTERY=$GREEN
export BATTERY_WARNING=$YELLOW
export BATTERY_CRITICAL=$RED
export BATTERY_BACKGROUND=$MODULE_BACKGROUND

export WIFI=$SKY              # Catppuccin Sky for WIFI
export WIFI_BACKGROUND=$MODULE_BACKGROUND

export VOLUME=$BLUE           # Catppuccin Blue for VOLUME
export VOLUME_BACKGROUND=$MODULE_BACKGROUND
