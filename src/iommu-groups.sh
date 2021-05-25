#!/usr/bin/env sh
# List all IOMMU groups and their devices, or all devices for a specified group.
# Usage: iommu-groups.sh [group] [-c]

if (echo "$1" | grep -Eq "^[0-9]+$") || (echo "$2" | grep -Eq "^[0-9]+$")
then

	# only specified group
	if (echo "$1" | grep -Eq "^[0-9]+$")
	then
		group="$1"
	else
		group="$2"
	fi

	if [ ! -e /sys/kernel/iommu_groups/"$group" ]
	then
		echo "/sys/kernel/iommu_groups/$group doesn't exist"
		exit 1
	fi

	#group number
	if [ "$1" = "-c" ] || [ "$2" = "-c" ]
	then
		printf "\e[31mIOMMU group %s\e[0m\n" "$(echo "$group" | grep -o "[0-9]*$")"
	else
		printf "IOMMU group %s\n" "$(echo "$group" | grep -o "[0-9]*$")"
	fi

	# devices
	for device in /sys/kernel/iommu_groups/"$group"/devices/*
	do
		printf "\t%s\n" "$(lspci -nns "$(echo "$device" | grep -o "[^/]*$")")"
	done

else

	# all groups
	for group in $(find /sys/kernel/iommu_groups -maxdepth 1 -mindepth 1 | grep -o "[0-9]*$" | sort -n)
	do
		# group number
		if [ "$1" = "-c" ] || [ "$2" = "-c" ]
		then
			printf "\e[31mIOMMU group %s\e[0m\n" "$(echo "$group" | grep -o "[0-9]*$")"
		else
			printf "IOMMU group %s\n" "$(echo "$group" | grep -o "[0-9]*$")"
		fi

		# devices
		for device in /sys/kernel/iommu_groups/"$group"/devices/*
		do
			printf "\t%s\n" "$(lspci -nns "$(echo "$device" | grep -o "[^/]*$")")"
		done
	done

fi
