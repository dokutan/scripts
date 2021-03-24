#!/bin/env sh
# A simple QEMU/KVM virtual machine
# remove "-net none" to enable networking
# add "-usb -device usb-host,vendorid=0x1234,productid=0x1234 \" for usb passthrough

QEMU="qemu-system-x86_64"
MEMORY=2G
CORES=6
MACHINE="q35"
CDROM="/path/to/disc.iso"
HDA="/path/to/disk.qcow2"
NAME="template"

"$QEMU" \
-machine "$MACHINE" \
-m "$MEMORY" \
-enable-kvm \
-cdrom "$CDROM" \
-hda "$HDA" \
-boot once=dc,menu=on \
-net none \
-usb -device usb-tablet \
-smp "$CORES" -cpu host \
-name "$NAME" "$@" \
