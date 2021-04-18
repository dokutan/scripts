#!/usr/bin/env sh
# Lists all leds in /sys/class/leds
# Usage: ls-leds.sh [-c]

for led in /sys/class/leds/*
do

	# name
	if [ "$1" = "-c" ]
	then
		printf "\e[31m%s\e[0m\n" "$led"
	else
		printf "%s\n" "$led"
	fi
	
	# device
	printf "\tdevice:\t\t%s\n" "$(cat "$led"/device/name)"
	
	# trigger
	printf "\ttrigger:\t%s\n" "$(grep -o "\[.*\]" "$led"/trigger | tr -d "[]")"
	
	# brightness
	printf "\tbrightness:\t%s/%s\n" "$(cat "$led"/brightness)" "$(cat "$led"/max_brightness)"
	
done
