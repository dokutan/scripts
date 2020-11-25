#!/bin/env sh
# A wrapper around openpyn for NordVPN connections.
# Disables NetworkManager to prevent DNS leaks.
# Usage:
# VPN start [2-letter country code]
# ^C && VPN stop
if [ "$1" = "start" ]
then
	systemctl stop NetworkManager.service
	openpyn -f "$2" --p2p
elif [ "$1" = "stop" ]
then
	openpyn -x
	systemctl start NetworkManager.service
else
	echo "unknown action, expected start or stop"
fi
