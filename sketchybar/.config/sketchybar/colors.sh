#!/bin/bash

# AI-generated colour palette to go with desktop background
# Names of variables aren't accurate.

# Background: #32374A (Your desktop and primary bar background)
#
# --- High Contrast, Dark Navy Palette ---
# Almost-white foregrounds, deep navy module backgrounds.

export RED=0xfff0a5ad      # Soft, desaturated light red for critical alerts
export YELLOW=0xffebdc9a    # Muted, light golden yellow for warnings
export ORANGE=0xffa6c1e1    # Lighter, desaturated blue for general accents
export GREEN=0xffa5ccb3    # Lighter, desaturated mint green

# Significantly darker and more opaque module backgrounds for clear distinction
export MODULE_BACKGROUND=0x881a202d # Very dark, almost black navy (50% opaque)

export GREEN_BG=$MODULE_BACKGROUND # Consistent deep dark navy for module backgrounds
export LAVENDER=0xffc0d8f0 # Light, desaturated cool blue/lavender
export LAVENDER_BG=$MODULE_BACKGROUND # Consistent deep dark navy for module backgrounds
export FLAMINGO=0xffadc6e9  # Lighter, desaturated slate blue
export FLAMINGO_BG=$MODULE_BACKGROUND # Consistent deep dark navy for module backgrounds

# Revised PINK: More distinct deep muted violet/amethyst
export PINK=0xffb1a6e0      # Deep muted violet/amethyst, distinct from text
export PINK_BG=$MODULE_BACKGROUND # Consistent deep dark navy for module backgrounds


# Primary text color: very light, almost pure white
export OVERLAY1=0xfff0f2f7 # Near-white, very subtle cool tint


# --- General bar colors ---
export BAR_COLOR=0x00000000 # Transparent (maintains current behavior)
export LABEL_COLOR=$OVERLAY1 # Use near-white for general labels for readability
# Popup background: slightly lighter than #32374A for subtle distinction
export POPUP_BACKGROUND_COLOR=0xF02e3243 # Maintain a dark but distinct popup bg

# --- Items (high contrast, white text on dark navy) ---
# White text on a consistent dark navy background for all modules

# Selected space background now uses the very dark MODULE_BACKGROUND
export SPACE_SELECTED=$LAVENDER # Active space text color
export SPACE_SELECTED_BACKGROUND=$MODULE_BACKGROUND # Very dark navy for active space

export SPACE=$OVERLAY1          # Unselected space text color (near-white)
export SPACE_BACKGROUND=0x00000000 # Keep unselected space background transparent

export CALENDAR=$LAVENDER
export CALENDAR_BACKGROUND=$MODULE_BACKGROUND

export BATTERY=$GREEN
export BATTERY_WARNING=$YELLOW
export BATTERY_CRITICAL=$RED
export BATTERY_BACKGROUND=$MODULE_BACKGROUND

export WIFI=$FLAMINGO
export WIFI_BACKGROUND=$MODULE_BACKGROUND

export VOLUME=$PINK
export VOLUME_BACKGROUND=$MODULE_BACKGROUND
