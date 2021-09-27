#!/usr/bin/env sh
# A minimal watchlist based on sqlite.

DB_PATH="$HOME/.watchlist.sqlite"

if [ "$1" = "init" ]; then
	printf "initializing database %s\n" "$DB_PATH"
	printf "CREATE TABLE IF NOT EXISTS watchlist(name STRING, status STRING, type STRING);\n.save %s" "$DB_PATH" | sqlite3
elif [ "$1" = "ls" ]; then
	printf "SELECT * FROM watchlist WHERE name LIKE '%%%s%%' OR status LIKE '%%%s%%' OR type LIKE '%%%s%%' ORDER BY status;\n" "$2" "$2" "$2" | sqlite3 -box "$DB_PATH"
elif [ "$1" = "new" ]; then
	printf "INSERT INTO watchlist VALUES ('%s', '%s', '%s');" "$2" "$3" "$4" | sqlite3 "$DB_PATH"
elif [ "$1" = "rm" ] && [ "$2" != "" ]; then
	printf "DELETE FROM watchlist WHERE name LIKE '%s';" "$2" | sqlite3 "$DB_PATH"
else
	printf "usage:\n%s init\n%s ls [query]\n%s new [name] [status] [type]\n%s rm [name]\n" "$0" "$0" "$0" "$0"
fi
