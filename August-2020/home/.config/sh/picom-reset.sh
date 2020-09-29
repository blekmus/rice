#!/bin/bash

if $(pgrep -x picom > /dev/null)
then
	killall picom 
	sleep 0.1
	picom -b
else
	picom -b
fi
