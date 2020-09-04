#!/bin/bash
# Theme
rofi_command="rofi -theme themes/screenshot.rasi"

# Options
screen=""
area=""
copy=""

# Variable passed to rofi
options="$screen\n$area\n$copy"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 1)"
case $chosen in
    $screen)
        maim -u ~/Pictures/Screenshots/$(date '+%Y_%m_%d-%H_%M_%S').png; dunstify "Screenshot taken" -i "/usr/share/icons/Numix/scalable/mimetypes/image-x-generic-symbolic.svg"
        ;;
    $area)
        maim -us ~/Pictures/Screenshots/$(date '+%Y_%m_%d-%H_%M_%S').png; dunstify "Screenshot taken" -i "/usr/share/icons/Numix/scalable/mimetypes/image-x-generic-symbolic.svg"
        ;;
    $copy)
        maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png; dunstify "Screenshot Copied" -i "/usr/share/icons/Numix/scalable/mimetypes/image-x-generic-symbolic.svg"
        ;;
esac
