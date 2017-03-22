#!/usr/bin/env bash

SCRIPT_DIR=`dirname "$BASH_SOURCE"`
ORIG_DIR=$1;
FILES="${SCRIPT_DIR}/*.patch"

[ -z "$ORIG_DIR" ] && { echo "Usage: $0 srcdir targetdir"; exit 1; }

[ ! -d "$ORIG_DIR" ] && { echo >&2 "Directory ${ORIG_DIR} does not exists. Aborting"; exit 1; }

for f in $FILES
do
  if [ -f "$f" ]
	then
		filename=$(basename "$f")
		patch -i "${f}" -p0
	fi
done





