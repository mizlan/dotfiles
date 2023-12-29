#!/bin/sh

# The wifi_change event supplies a $INFO variable in which the current SSID
# is passed to the script.

# ref: https://github.com/FelixKratz/SketchyBar/issues/407#issuecomment-1755765318
INFO="$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I  | awk -F' SSID: '  '/ SSID: / {print $2}')"

WIFI=${INFO:-"Not Connected"}

sketchybar --set $NAME label="${WIFI}"
