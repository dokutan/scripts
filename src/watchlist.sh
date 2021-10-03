#!/usr/bin/env sh
# A minimal watchlist based on sqlite.

DB_PATH="$HOME/.watchlist.sqlite"
SQLITE="sqlite3 -box $DB_PATH"

if [ "$1" = "init" ]; then
	printf "initializing database %s\n" "$DB_PATH"
	printf "CREATE TABLE IF NOT EXISTS watchlist(name STRING, status STRING, type STRING);\n.save %s" "$DB_PATH" | $SQLITE
elif [ "$1" = "ls" ]; then
	printf "SELECT * FROM watchlist WHERE name LIKE '%%%s%%' OR status LIKE '%%%s%%' OR type LIKE '%%%s%%' ORDER BY status;\n" "$2" "$2" "$2" | $SQLITE
elif [ "$1" = "new" ]; then
	printf "INSERT INTO watchlist VALUES ('%s', '%s', '%s');" "$2" "$3" "$4" | $SQLITE
elif [ "$1" = "rm" ] && [ "$2" != "" ]; then
	printf "DELETE FROM watchlist WHERE name LIKE '%%%s%%';" "$2" | $SQLITE
elif [ "$1" = "set" ]; then
       printf "UPDATE watchlist SET status = '$3' WHERE name LIKE '%%%s%%';" "$2" | $SQLITE
else
	printf "usage:\n%s init\n%s ls [query]\n%s new [name] [status] [type]\n%s rm [name]\n%s set [name] [status]\n" "$0" "$0" "$0" "$0" "$0"
fi
