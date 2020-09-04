#!/bin/bash

rofi_command="rofi -theme themes/network.rasi"


# variables
eth_status="$(nmcli device | grep 'ethernet' | awk '{ print $3 }')"  # connected/>
wifi_status="$(nmcli device | grep 'wifi' | awk '{ print $3 }')"
wifi_device_status="$(nmcli radio wifi)" # enabled/disabled

# icons
bmon="龍"
nm_tui=""
nm_editor="歷"
wifi="直"
eth=""

# Connectivity
active=''
if (ping -c 1 google.com || ping -c 1 github.com) &>/dev/null; then
    if [[ $eth_status == 'connected'  ]]; then
        active='-a 0'
    fi

    if [[ $wifi_status == 'connected' ]]; then
        active='-a 1'
    elif [[ $wifi_device_status != 'enabled' ]]; then
        wifi='睊'
    fi

elif [[ $wifi_device_status != 'enabled' ]]; then
	wifi='睊'
fi

# Output
options="$eth\n$wifi\n$bmon\n$nm_tui\n$nm_editor"
chosen="$(echo -e $options | $rofi_command -dmenu $active -selected-row 2)"

case $chosen in
    $eth) 
	if [[ $eth_status == 'connected' ]]; then
	    nmcli device disconnect eno1
        else
            nmcli device connect eno1
        fi
	;;
    $wifi)
        if [[ $wifi_device_status == 'enabled' ]]; then
            nmcli radio wifi off
        else
            nmcli radio wifi on
        fi
        ;;
    $bmon)
        kitty -e bmon
        ;;
    $nm_tui)
        kitty -e nmtui
        ;;
    $nm_editor)
        nm-connection-editor
        ;;
esac
