#!/usr/bin/env sh
# Download photos from Google Photos, tested/used with Firefox.
# Written because downloading all photos as a .zip file failed. 

echo "Click on the first photo"
sleep 1

while true; do
    echo "$(date --iso-8601=seconds)    downloading photo..."
    xdotool key Shift+D # download photo
    sleep 2
    xdotool click 1 # close donwloads
    sleep 1
    xdotool key Right # next photo
    sleep 1
done
