#!/usr/bin/env sh
# Show common ANSI escape sequences.

echo "SGR"
printf "    \\\\e[<0-127>m\n\n"
for i in $(seq 0 127)
do
	printf "%4d\x1b[%sm%4d\x1b[0m" "$i" "$i" "$i"
	if [ $((("$i" + 1) % 8)) = "0" ]
	then
		echo
	fi
done

echo
echo "8-bit color"
printf "    fg: \\\\e[38;5;<0-255>m\n    bg: \\\\e[48;5;<0-255>m\n\n"
for i in $(seq 0 255)
do
	printf "%4d\x1b[48;5;%sm   \x1b[0m" "$i" "$i"
	if [ $((("$i" + 1) % 8)) = "0" ]
	then
		echo
	fi
done
