#!/usr/bin/env bash

TAG="v15.4.2"
CURRENT=`pwd`
SRC_DIR="src"
REACT_SRC_DIR="src-react"

# Set the variable for bash behavior
shopt -s nullglob
shopt -s dotglob

fetch() {
	[ -z "$1" ] && { echo >&2 "You must provide url to fetch"; exit 1; }
	if
		! curl --silent --show-error --fail --write-out "Fetching %{filename_effective} %{http_code}\n" -O $1; then
		echo >&2 "Fetch failed"; exit $?;
	fi
}

# check if SRC_DIR exists -> prevent overwriting of files
chk_files=(${SRC_DIR}/*)
(( ${#chk_files[*]} )) && { echo >&2 "Directory ${SRC_DIR} is not empty. Aborting"; exit 1; }

# test curl presence
command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it's not installed.  Aborting."; exit 1; }

mkdir -p $SRC_DIR
mkdir -p $REACT_SRC_DIR

# fetch react transitions
pushd $SRC_DIR
fetch https://raw.githubusercontent.com/facebook/fbjs/master/packages/fbjs/src/__forks__/invariant.js
fetch https://raw.githubusercontent.com/facebook/fbjs/master/packages/fbjs/src/__forks__/warning.js
fetch https://raw.githubusercontent.com/facebook/react/${TAG}/src/shared/utils/getIteratorFn.js
fetch https://raw.githubusercontent.com/facebook/react/${TAG}/src/shared/utils/KeyEscapeUtils.js
fetch https://raw.githubusercontent.com/facebook/react/${TAG}/src/renderers/dom/client/utils/getVendorPrefixedEventName.js
fetch https://raw.githubusercontent.com/facebook/react/${TAG}/src/shared/utils/flattenChildren.js
fetch https://raw.githubusercontent.com/facebook/react/${TAG}/src/shared/utils/traverseAllChildren.js
fetch https://raw.githubusercontent.com/facebook/react/${TAG}/src/addons/transitions/ReactCSSTransitionGroup.js
fetch https://raw.githubusercontent.com/facebook/react/${TAG}/src/addons/transitions/ReactCSSTransitionGroupChild.js
fetch https://raw.githubusercontent.com/facebook/react/${TAG}/src/addons/transitions/ReactTransitionChildMapping.js
fetch https://raw.githubusercontent.com/facebook/react/${TAG}/src/addons/transitions/ReactTransitionEvents.js
fetch https://raw.githubusercontent.com/facebook/react/${TAG}/src/addons/transitions/ReactTransitionGroup.js
popd

cp "${SRC_DIR}"/* $REACT_SRC_DIR

./patches/applypatches.sh "patches"

# Unset the variable  for bash behavior
shopt -u nullglob
shopt -u dotglob
