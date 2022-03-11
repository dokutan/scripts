#!/usr/bin/env sh
# An interactive wrapper for `mpc searchplay`.

[ -t 1 ] && MENU="fzf" || MENU="rofi -dmenu -i"
mpc searchplay "$(mpc list title | $MENU)"

