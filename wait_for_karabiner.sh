#!/bin/bash

KANATA_PATH="/Users/williamferns/.local/bin/kanata_macos_arm64"
KANATA_CFG_PATH="/Users/williamferns/.config/kanata.kbd"

# Wait for Karabiner to start
while ! pgrep -x "Karabiner-VirtualHIDDevice-Daemon" >/dev/null; do
    sleep 1
done

# Start your daemon
sudo "$KANATA_PATH" -c "$KANATA_CFG_PATH" -n
