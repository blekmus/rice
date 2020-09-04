#!/bin/bash

killall -q polybar

polybar -r main &
polybar -r logo_power
