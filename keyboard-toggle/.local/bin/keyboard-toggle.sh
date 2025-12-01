#!/usr/bin/env bash
set -e

INTERNAL_KB="1:1:AT_Translated_Set_2_keyboard"
BT_KB="HHKB-Hybrid_2"

while true; do
  MAC=$(bluetoothctl devices | grep "$BT_KB" | awk '{print $2}')

  if bluetoothctl info "$MAC" | grep -q "Connected: yes"; then
    echo "Disabling internal keyboard - bluetooth connected."
    swaymsg input "$INTERNAL_KB" events disabled
  else
    echo "Enabling internal keyboard - bluetooth not connected."
    swaymsg input "$INTERNAL_KB" events enabled
  fi

  sleep 10
done
