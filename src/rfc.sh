#!/usr/bin/env sh
# Displays the RFC with the given number, requires the RFCs to be installed locally
# Usage: rfc.sh number

RFCPATH="/usr/share/doc/rfc/txt"

if [ "$MANPAGER" = "" ]
then
	RFCPAGER="less"
else
	RFCPAGER="$MANPAGER"
fi

$RFCPAGER "$RFCPATH/rfc$1.txt"

