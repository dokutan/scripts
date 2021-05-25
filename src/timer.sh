#!/usr/bin/env sh
# A simple timer, gives a notification after the specified amount of time has passed.

if [ "$1" = "" ]
then
	echo "Usage: $0 duration"
	echo "man sleep(1) for details"
else
	(sleep "$@" && notify-send "timer.sh" "Timer $* has finished"; canberra-gtk-play -i alarm-clock-elapsed) &
fi
