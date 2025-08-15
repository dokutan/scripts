#!/usr/bin/env sh
# identify potentially corrupted files on btrfs
# usage: btrfs-warning-files.sh mountpoint

devices=""
for dev in $(btrfs filesystem show "$1" | grep -Eo "/dev/[^ ]+")
do
	devices="$devices|$(basename "$(realpath "$dev")")"
done
devices="$(echo "$devices" | sed "s/^|//")"

echo "devices: $devices"
echo ""
echo "files:"

for off in $(dmesg | grep "BTRFS warning" | grep -E "device ($devices)" | grep -Eo "off [0-9]+" | sed "s/off //")
do
	btrfs inspect-internal logical-resolve "$off" "$1"
done
