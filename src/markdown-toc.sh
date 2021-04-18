#!/usr/bin/env sh
# Generate a table of contents for a given markdown file
# Usage: makrdown-toc.sh file.md [-l]

if [ "$2" = "-l" ]
then
	IFS=
	grep "^#" "$1" | while read -r l
	do
		echo "$(echo "$l" | sed 's/# /- [/;s/#/\t/g')](#$(echo "$l" | sed 's/#* //' | tr 'A-Z ' 'a-z-' | tr -d '/'))"
	done
else
	grep "^#" "$1" | sed "s/# /- /;s/#/\t/g"
fi
