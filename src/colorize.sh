#!/usr/bin/env sh
# Changes the terminal colors while a command is running.
# Usage: colorize.sh fg bg command
# Example: colorize.sh 0 00ff00 ssh user@host
# Colors can be specified as rrggbb or rgb, use 0 to keep the original color.

trap 'printf "\e]110\a\e]111\a"' EXIT
printf "\e]10;#%s\a\e]11;#%s\a" "$1" "$2"
shift 2
"${@}"
