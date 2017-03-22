#!/usr/bin/env bash

SCRIPT_DIR=`dirname "$BASH_SOURCE"`
ORIG_DIR=$1;
NEW_DIR=$2;
FILES="${NEW_DIR}/*"

[ -z "$ORIG_DIR" ] && { echo "Usage: $0 origdir newdir"; exit 1; }
[ -z "$NEW_DIR" ] && { echo "Usage: $0 origdir newdir"; exit 1; }

[ ! -d "$ORIG_DIR" ] && { echo >&2 "Directory ${ORIG_DIR} does not exists. Aborting"; exit 1; }
[ ! -d "$NEW_DIR" ] && { echo >&2 "Directory ${NEW_DIR} does not exists. Aborting"; exit 1; }

for f in $FILES
do
  if [ -f "$f" ]
	then
		filename=$(basename ${f})
		patchname="$(basename ${f%.*}).patch"
		echo "Creating ${patchname}..."
		diff -uN "${ORIG_DIR}/${filename}" $f > "${SCRIPT_DIR}/${patchname}"
	fi
done





