#!/bin/env sh
# Attempts to obtain a list of keybindings for AwesomeWM.
# Should fail if awful.key() is on a different line than the modifiers table or key string.
# Includes the keybinding even if awful.key() is commented out or behind an if statement.
RC=$HOME"/.config/awesome/rc.lua"
grep "awful.key" $RC | grep "\{.*\},\s*\"[^\"]*\"" -o | tr -d " \t" | sort | uniq
