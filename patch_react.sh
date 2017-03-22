#!/usr/bin/env bash

TAG="v15.4.2"
CURRENT=`pwd`
SRC_DIR="src"
REACT_DIR="${SRC_DIR}/__react"

# Set the variable for bash behavior
shopt -s nullglob
shopt -s dotglob

# check if REACT_DIR exists -> prevent overwriting of files
chk_files=(${REACT_DIR}/*)
(( ${#chk_files[*]} )) && { echo >&2 "Directory ${REACT_DIR} is not empty. Aborting"; exit 1; }

# test curl presence
command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it's not installed.  Aborting."; exit 1; }

# fetch react transitions
mkdir -p $REACT_DIR
pushd $REACT_DIR
curl -O https://raw.githubusercontent.com/facebook/fbjs/master/packages/fbjs/src/__forks__/invariant.js
curl -O https://raw.githubusercontent.com/facebook/fbjs/master/packages/fbjs/src/__forks__/warning.js
curl -O https://raw.githubusercontent.com/facebook/react/${TAG}/src/shared/utils/getIteratorFn.js
curl -O https://raw.githubusercontent.com/facebook/react/${TAG}/src/shared/utils/KeyEscapeUtils.js
curl -O https://raw.githubusercontent.com/facebook/react/${TAG}/src/renderers/dom/client/utils/getVendorPrefixedEventName.js
curl -O https://raw.githubusercontent.com/facebook/react/${TAG}/src/shared/utils/flattenChildren.js
curl -O https://raw.githubusercontent.com/facebook/react/${TAG}/src/shared/utils/traverseAllChildren.js
curl -O https://raw.githubusercontent.com/facebook/react/${TAG}/src/addons/transitions/ReactCSSTransitionGroup.js
curl -O https://raw.githubusercontent.com/facebook/react/${TAG}/src/addons/transitions/ReactCSSTransitionGroupChild.js
curl -O https://raw.githubusercontent.com/facebook/react/${TAG}/src/addons/transitions/ReactTransitionChildMapping.js
curl -O https://raw.githubusercontent.com/facebook/react/${TAG}/src/addons/transitions/ReactTransitionEvents.js
curl -O https://raw.githubusercontent.com/facebook/react/${TAG}/src/addons/transitions/ReactTransitionGroup.js
popd

# Unset the variable  for bash behavior
shopt -u nullglob
shopt -u dotglob
