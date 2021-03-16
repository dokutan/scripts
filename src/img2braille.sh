#!/bin/env sh
# Uses GraphicsMagick to display an image using braille characters
# Usage img2braille.sh image [width]

WIDTH=$(tput cols)
if [ -n "$2" ]; then
	WIDTH="$2"
fi
gm convert -resize "$WIDTH" "$1" UBRL:- | sed "/^$/d;/.*:.*/d"
