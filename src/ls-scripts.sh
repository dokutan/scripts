#!/usr/bin/env sh
# List all scripts and their description.

for script in "$(dirname "$0")"/*
do
	# filename
	if [ "$1" = "-c" ]
	then
		printf "\e[31m%s\e[0m\n" "$script"
	else
		printf "%s\n" "$script"
	fi

	# description
	sed -n "/^#/p;/^[^#]/q;/^$/q" "$script"

	printf "\n"
done
