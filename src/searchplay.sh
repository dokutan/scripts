#!/usr/bin/env sh
# An interactive wrapper for `mpc searchplay`.

[ -t 1 ] && MENU="fzf +s" || MENU="rofi -dmenu -i"
RESULT="$(mpc playlist -f "%artist%\t%album%\t%track%\t%title%" | $MENU)" || exit 1
mpc searchplay \
	artist "$(echo "$RESULT" | cut -f 1)" \
	album "$(echo "$RESULT" | cut -f 2)" \
	title "$(echo "$RESULT" | cut -f 4)" 
