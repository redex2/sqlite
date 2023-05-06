#!/bin/bash
set -euo pipefail

wget -qO- https://sqlite.org/src/tarball/release/sqlite.tar.gz | tar xz

mkdir sqlite/build
cd sqlite/build

../configure
make sqlite3.c
cd ../..

anyDiff=0

set +e
diff sqlite3.c sqlite/build/sqlite3.c >> /dev/null
if [ $? -ne 0 ]
then
	anyDiff=1
	cp sqlite/build/sqlite3.c sqlite3.c
fi
diff sqlite3.h sqlite/build/sqlite3.h >> /dev/null
if [ $? -ne 0 ]
then
	anyDiff=1
	cp sqlite/build/sqlite3.h sqlite3.h
fi
set -e

rm -r sqlite

if [ $anyDiff -eq 1 ]
then
	cmake -B build || echo "failed build - aborted" && exit 0
	rm -r build
	git commit -am "update"
	git push
else
	echo "up to date"
fi

echo "OK"
exit 0

