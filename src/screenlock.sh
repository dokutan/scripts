#!/usr/bin/env sh
# turn display off, disable console switching, lock
# enable console switching after unlock

# lockscreen image
IMAGE="/path/to/image.png"

xset dpms force off
physlock -l
i3lock -n -i $IMAGE
physlock -L
