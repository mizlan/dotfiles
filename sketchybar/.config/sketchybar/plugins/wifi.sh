#!/bin/sh

# The wifi_change event supplies a $INFO variable in which the current SSID
# is passed to the script.

# ref: https://github.com/FelixKratz/SketchyBar/issues/407#issuecomment-1755765318
INFO="$(ipconfig getsummary "$(networksetup -listallhardwareports | awk '/Wi-Fi|AirPort/{getline; print $NF}')" | grep '  SSID : ' | awk -F ': ' '{print $2}')"


WIFI=${INFO:-"Not Connected"}

sketchybar --set $NAME label="${WIFI}"
