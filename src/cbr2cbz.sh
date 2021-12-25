#!/usr/bin/env sh
# converts .cbr files to .cbz files
# usage: cbr2cbz.sh file1.cbr file2.cbr ...

tmpdir="$(mktemp -d)"

for f in "$@"
do
	name=$(basename "$f" .cbr)
	if [ ! -f "$name.cbz" ]
	then
		mkdir "$tmpdir/$name"
		unrar x "$f" "$tmpdir/$name"
		zip -rj "$name.cbz" "$tmpdir/$name"
	fi
done

rm -rf "$tmpdir"
