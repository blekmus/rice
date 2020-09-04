#!/bin/bash
# Theme
rofi_command="rofi -theme themes/powermenu.rasi"

# Options
shutdown="襤"
reboot="ﰇ"
lock=""
suspend="鈴"

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend"


chosen="$(echo -e "$options" | $rofi_command -dmenu)"
case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        exit i3
        ;;
    $suspend)
        systemctl suspend
        ;;
esac

