#!/bin/bash

# Kanagawa Wave theme (Default Dark) for sketchybar

# Base Colors
export BASE=0xff1f1f28      # sumiInk1 (Main BG)
export MANTLE=0xff181820    # sumiInk0 (Darker BG)
export CRUST=0xff16161d     # sumiInk1 (Solid base)

# Text Colors
export TEXT=0xffdcd7ba      # fujiWhite (Primary Text)
export SUBTEXT0=0xffa6a28c  # fujiGray (Dimmer text)
export SUBTEXT1=0xff8a8a81  # springGray (Grayish)

# Accent Colors
export ROSEWATER=0xffc8c093 # fujiWhite (Cream/Beige)
export FLAMINGO=0xffd27e99  # sakuraPink
export PINK=0xff957fb8      # oniViolet
export MAUVE=0xff938aa9     # kasumiBlue
export RED=0xffc34043       # fuyuRed
export MAROON=0xffe82424    # crystalRed
export PEACH=0xffffa066     # surimiOrange
export YELLOW=0xffc0a36e    # carpYellow
export GREEN=0xff76946a     # autumnGreen
export TEAL=0xff7aa89f      # boatYellow2 (Aqua/Teal)
export SKY=0xff8eafad       # waveAqua1
export SAPPHIRE=0xff658594  # waveBlue1
export BLUE=0xff7e9cd8      # crystalBlue
export LAVENDER=0xff957fb8  # oniViolet

# Your sketchybar variable mapping to Kanagawa Wave
export RED=$RED               # Kanagawa Red
export YELLOW=$YELLOW         # Kanagawa Yellow
export ORANGE=$PEACH          # Kanagawa Orange
export GREEN=$GREEN           # Kanagawa Green

# Module backgrounds - solid Kanagawa colors
export MODULE_BACKGROUND=$MANTLE 

export GREEN_BG=$MODULE_BACKGROUND
export LAVENDER=$LAVENDER     
export LAVENDER_BG=$MODULE_BACKGROUND
export FLAMINGO=$FLAMINGO     
export FLAMINGO_BG=$MODULE_BACKGROUND

export PINK=$PINK             
export PINK_BG=$MODULE_BACKGROUND

export OVERLAY1=$TEXT         # Primary foreground

# General bar colors
export BAR_COLOR=$BASE        # Main bar color
export LABEL_COLOR=$TEXT      
export POPUP_BACKGROUND_COLOR=$CRUST 

# Items
export SPACE_SELECTED=$BLUE   # Kanagawa Blue for active state
export SPACE_SELECTED_BACKGROUND=$CRUST 

export SPACE=$SUBTEXT0        
export SPACE_BACKGROUND=$MANTLE 

export CALENDAR=$ROSEWATER    # Use the cream color for calendar
export CALENDAR_BACKGROUND=$MODULE_BACKGROUND

export BATTERY=$GREEN
export BATTERY_WARNING=$YELLOW
export BATTERY_CRITICAL=$RED
export BATTERY_BACKGROUND=$MODULE_BACKGROUND

export WIFI=$TEAL             
export WIFI_BACKGROUND=$MODULE_BACKGROUND

export VOLUME=$BLUE           
export VOLUME_BACKGROUND=$MODULE_BACKGROUND
