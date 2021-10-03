#!/usr/bin/env bash
# Fills the terminal with a random color.

COLOR=$((RANDOM % 256))
BG=$(tput setab "$COLOR")
CLEAR=$(tput clear)

trap "tput cvvis" EXIT
tput civis

while true
do
	printf "%s%s" "$BG" "$CLEAR"
	sleep 1
done
