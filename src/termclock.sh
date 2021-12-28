#!/usr/bin/env sh
# A simple clock

# options
INTERVAL="1s"
DATE="date +%T"
FIGLET="figlet -t -c -W"
FG_COLOR=$(tput setaf 202)
BG_COLOR=$(tput setab 236)
CLEAR=$(tput clear)

# cleanup on exit
trap cleanup EXIT
cleanup() {
	tput cvvis # enable cursor
	tput sgr0  # disable colors
	clear
}

# hide cursor
tput civis

while true
do
	# get and format the current date
	CURRENT_DATE=$($DATE | $FIGLET)

	# calculate the center y coordinate
	HEIGHT=$(echo "$CURRENT_DATE" | wc -l)
	ROWS=$(tput lines)
	Y=$((("$ROWS" - "$HEIGHT") / 2))

	printf "%s%s%s%s%s\n" "$BG_COLOR" "$FG_COLOR" "$CLEAR" "$(tput cup "$Y" 0)" "$CURRENT_DATE"
	sleep "$INTERVAL"
done
