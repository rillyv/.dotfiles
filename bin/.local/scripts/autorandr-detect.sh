#!/usr/bin/env bash

if xrandr | grep -q '^HDMI-2 connected'; then
  autorandr --load docked
else
  autorandr --load undocked
fi

