#!/usr/bin/env sh
# Add a border around text from a file or stdin.
# Usage: box.sh charset [file]

case "$1" in
"ascii")
	CHAR_N="-"
	CHAR_E="|"
	CHAR_S="-"
	CHAR_W="|"
	CHAR_NE="+"
	CHAR_SE="+"
	CHAR_SW="+"
	CHAR_NW="+"
	;;
"asm")
	CHAR_N="-"
	CHAR_E=";"
	CHAR_S="-"
	CHAR_W=";"
	CHAR_NE=";"
	CHAR_SE=";"
	CHAR_SW=";"
	CHAR_NW=";"
	;;
"asm2")
	CHAR_N="="
	CHAR_E=";"
	CHAR_S="="
	CHAR_W=";"
	CHAR_NE=";"
	CHAR_SE=";"
	CHAR_SW=";"
	CHAR_NW=";"
	;;
"c")
	CHAR_N="*"
	CHAR_E="*/"
	CHAR_S="*"
	CHAR_W="/*"
	CHAR_NE="*/"
	CHAR_SE="*/"
	CHAR_SW="/*"
	CHAR_NW="/*"
	;;
"numbersign")
	CHAR_N="#"
	CHAR_E="#"
	CHAR_S="#"
	CHAR_W="#"
	CHAR_NE="#"
	CHAR_SE="#"
	CHAR_SW="#"
	CHAR_NW="#"
	;;

"light")
	CHAR_N="─"
	CHAR_E="│"
	CHAR_S="─"
	CHAR_W="│"
	CHAR_NE="┐"
	CHAR_SE="┘"
	CHAR_SW="└"
	CHAR_NW="┌"
	;;
"heavy")
	CHAR_N="━"
	CHAR_E="┃"
	CHAR_S="━"
	CHAR_W="┃"
	CHAR_NE="┓"
	CHAR_SE="┛"
	CHAR_SW="┗"
	CHAR_NW="┏"
	;;
"double")
	CHAR_N="═"
	CHAR_E="║"
	CHAR_S="═"
	CHAR_W="║"
	CHAR_NE="╗"
	CHAR_SE="╝"
	CHAR_SW="╚"
	CHAR_NW="╔"
	;;
*)
	echo "usage: $0 charset [file]"
	echo "valid charsets are: ascii, asm, asm2, c, numbersign, light, heavy, double"
	exit 1
	;;
esac

FILE="$2"
# if no file is specified, read from stdin and store in temporary file
if [ -z "$2" ]
then
	FILE="$(mktemp)"
	IFS=""
	while read -r line
	do
		echo "$line" >> "$FILE"
	done
fi

# get length of the longest line
WIDTH=$(wc -L "$FILE" | grep -o "^[0-9]*")

# print top border
printf "%s" "$CHAR_NW"
printf "%${WIDTH}s" | sed "s/ /$CHAR_N/g"
printf "%s\n" "$CHAR_NE"

# print file contents
while read -r line
do
	# get length of the current line
	LENGTH=$(printf "%s" "$line" | wc -c)

	printf "%s" "$CHAR_W"
	printf "%s" "$line"
	printf "%$(("$WIDTH" - "$LENGTH"))s"
	printf "%s\n" "$CHAR_E"
done < "$FILE"

# print bottom border
printf "%s" "$CHAR_SW"
printf "%${WIDTH}s" | sed "s/ /$CHAR_S/g"
printf "%s\n" "$CHAR_SE"

# delete temporary file
if [ -z "$2" ]
then
	rm "$FILE"
fi

