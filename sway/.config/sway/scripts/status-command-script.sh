#!/bin/sh

while true; do
  battery_info=$(acpi)
  percentage=$(echo "$battery_info" | grep -Eo '[0-9]+%' | tr -d '%')
  status=$(echo "$battery_info" | awk -F ', ' '{print $1}' | awk '{print $3}')
  datetime=$(date '+%Y-%m-%d | %H:%M:%S')

  if [ "$status" = "Charging" ]; then
    echo "⚡ $percentage% | $datetime"
  else
    echo "🔋 $percentage% | $datetime"
  fi

  sleep 1
done

