#!/bin/bash

# Log file (for debugging)
log_file="/tmp/lid-handler.log"
echo "$(date): Script triggered" >> "$log_file"

# Udev doesn't pass env vars needed for swaymsg
export SWAYSOCK=/run/user/1000/sway-ipc.1000.901.sock
export WAYLAND_DISPLAY=wayland-1
export XDG_RUNTIME_DIR=/run/user/1000

# Read lid state
lid_path="/proc/acpi/button/lid/LID0/state"
if [ ! -f "$lid_path" ]; then
    echo "Lid state file not found" >> "$log_file"
    exit 1
fi

lid_state=$(awk '{print $2}' < "$lid_path")
echo "Lid state: $lid_state" >> "$log_file"

if [ "$lid_state" = "closed" ]; then
    swaymsg output eDP-1 disable >> "$log_file" 2>&1
else
    swaymsg output eDP-1 enable >> "$log_file" 2>&1
fi

