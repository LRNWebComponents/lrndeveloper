#!/bin/bash
# This will walk into each directory in this set and ensure it's demo is up to date
# and pushed up to github

# where am i? move to where I am. This ensures source is properly sourced
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

#provide messaging colors for output to console
txtbld=$(tput bold)             # Bold
bldgrn=${txtbld}$(tput setaf 2) #  green
bldred=${txtbld}$(tput setaf 1) #  red
txtreset=$(tput sgr0)
lrnecho(){
  echo "${bldgrn}$1${txtreset}"
}
lrnwarn(){
  echo "${bldred}$1${txtreset}"
}

# move into the build directory
cd ~/LRNWebcomponents/build
# build which will have the new item roped in
polymer build
# move to build directory
cd build/default
# smash it into 1 file
vulcanize index.html > build.html
# move back to root of build repo
cd ../..
cp -R components-to-copy/ build/default/bower_components/
# add all changes for this
git add -A
git commit -m "updated build dependencies"
git push origin master
# now make change in the build for edit derivative
# move into the build directory
cd ../build-for-edit
# build which will have the new item roped in
polymer build
# move to build directory
cd build/default
# smash it into 1 file
vulcanize index.html > build.html
# move back below the repo
cd ../../..
# support for updating ELMSLN copy of this
cp build/build/default/build.html ~/elmsln/core/webcomponents/elements/_build/build.html
cp build/build/default/push-manifest.json ~/elmsln/core/webcomponents/elements/_build/manifest.json
cp build/build/default/service-worker.js ~/elmsln/core/webcomponents/elements/_build/service-worker.js
cp build-for-edit/build/default/build.html ~/elmsln/core/webcomponents/elements/_build/build_edit.html

echo "LRN build files have been updated"