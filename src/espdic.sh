#!/usr/bin/env sh
# A script to search in ESPDIC (http://denisowski.org/Esperanto/ESPDIC/espdic_readme.html).

# determine path of espdic.txt
[ -z "$XDG_DATA_HOME" ] && DICT_PATH="$HOME/.local/share/espdic.sh" || DICT_PATH="$XDG_DATA_HOME/espdic.sh"

# download espdic ?
[ -f "$DICT_PATH/espdic.txt" ] || (
	echo "downloading espdic.txt"
	mkdir -p "$DICT_PATH"
	curl "http://www.denisowski.org/Esperanto/ESPDIC/espdic.txt" > "$DICT_PATH/espdic.txt"
	sed -i "s/\r//g" "$DICT_PATH/espdic.txt"
)

[ -t 1 ] && MENU="fzf" || MENU="rofi -dmenu -i"
tail -n +2 "$DICT_PATH/espdic.txt" | $MENU
