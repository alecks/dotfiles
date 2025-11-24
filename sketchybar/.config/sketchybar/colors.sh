#!/bin/bash

# Background: #32374A (Your desktop and primary bar background)
# Goal: Maximum readability with white text, on darker navy module backgrounds.
#       Overall theme remains deep and desaturated.

# --- High Contrast, Dark Navy Palette ---
# Almost-white foregrounds, deep navy module backgrounds.

export RED=0xfff0a5ad      # Soft, desaturated light red for critical alerts
export YELLOW=0xffebdc9a    # Muted, light golden yellow for warnings
export ORANGE=0xffa6c1e1    # Lighter, desaturated blue for general accents
export GREEN=0xffa5ccb3    # Lighter, desaturated mint green
export GREEN_BG=0x552c3342 # Deep dark navy with a hint of green (more opaque)
export LAVENDER=0xffc0d8f0 # Light, desaturated cool blue/lavender
export LAVENDER_BG=0x552c3342 # Deep dark navy (more opaque)
export FLAMINGO=0xffadc6e9  # Lighter, desaturated slate blue
export FLAMINGO_BG=0x552c3342 # Deep dark navy (more opaque)
export PINK=0xffb6c4da      # Lighter, desaturated grey-blue/plum
export PINK_BG=0x552c3342   # Deep dark navy (more opaque)


# Primary text color: very light, almost pure white
export OVERLAY1=0xfff0f2f7 # Near-white, very subtle cool tint


# --- General bar colors ---
export BAR_COLOR=0x00000000 # Transparent (maintains current behavior)
export LABEL_COLOR=$OVERLAY1 # Use near-white for general labels for readability
# Popup background: slightly lighter than #32374A for subtle distinction
export POPUP_BACKGROUND_COLOR=0xF02e3243 # Maintain a dark but distinct popup bg

# --- Items (high contrast, white text on dark navy) ---
# White text on a consistent dark navy background for all modules

export SPACE_SELECTED=$LAVENDER # Active space text color
export SPACE_SELECTED_BACKGROUND=$LAVENDER_BG # Consistent dark navy background
export SPACE=$OVERLAY1          # Unselected space text color (near-white)
export SPACE_BACKGROUND=0x00000000 # Keep unselected space background transparent

export CALENDAR=$LAVENDER
export CALENDAR_BACKGROUND=$LAVENDER_BG

export BATTERY=$GREEN
export BATTERY_WARNING=$YELLOW
export BATTERY_CRITICAL=$RED
export BATTERY_BACKGROUND=$GREEN_BG

export WIFI=$FLAMINGO
export WIFI_BACKGROUND=$FLAMINGO_BG

export VOLUME=$PINK
export VOLUME_BACKGROUND=$PINK_BG
