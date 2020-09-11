#!/bin/bash

# Change color to alternate hook
polybar-msg hook "$1" 2

# Run rofi overlay script
source "$HOME/.config/rofi/scripts/$2.sh"

# Loop to track if rofi overlay has been closed
while :
do
	if [[ -z $(pidof -x rofi) ]];
	then
		# Change color back to original hook
		polybar-msg hook "$1" 1
		break
	fi
done
