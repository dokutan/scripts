#!/usr/bin/env python3
# Sort the mpd play queue

from mpd import MPDClient

def int_or_zero(string):
    try:
        if type(string)==list:
            return int_or_zero(string[0])
        else:
            return int(string)
    except:
        return 0

client = MPDClient()
client.connect("localhost", 6600)

queue        = client.playlistinfo()
sorted_queue = sorted(queue, key=lambda x: [x.get("albumartist", x.get("artist", "")), x.get("album", ""), int_or_zero(x.get("track", "")), x["file"]])

client.clear()

added_songs = set()
for song in sorted_queue:
    if not song["file"] in added_songs:
        client.add(song["file"])
        added_songs.add(song["file"])

client.close()
client.disconnect()
