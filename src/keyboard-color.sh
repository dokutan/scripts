#!/usr/bin/env sh
# GUI to change the LED color on keyboards supported by https://github.com/dokutan/rgb_keyboard

# get color from user
values=$(zenity --color-selection --show-palette | sed 's/[rgb()]//g' | tr "," "\n")

# convert decimal rgb values to one hexadecimal rgb value
for c in $values
do
	d="$d"$(printf "%02x" "$c")
done

# echo "$d"
rgb_keyboard --color "$d"
