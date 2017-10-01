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
#repo in question
repo=$1
if [ -z $1 ]; then
  read -rp "Repo name: " repo
fi
# go back a level so we have all the repos here
cd ~/LRNWebcomponents/$repo
# commit message
commit=$2
if [ -z $2 ]; then
  read -rp "Commit message: " commit
fi
# add everything in from this repo
git add -A
git commit -m "$commit"
git push origin master

# tag for this repo
tag=$3
git tag
if [ -z $3 ]; then
  read -rp "Tag: " tag
fi
# push to this tag
git tag $tag
git push origin $tag
# update demo to match
sh update-demo.sh
# move into the build directory
cd ../build
# install which will then update to this tag
bower install --save LRNWebcomponents/$repo
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
git commit -m "updated downstream $repo"
git push origin master
# now make change in the build for edit derivative
# move into the build directory
cd ../build-for-edit
# install which will then update to this tag
bower install --save LRNWebcomponents/$repo
# build which will have the new item roped in
polymer build
# move to build directory
cd build/default
# smash it into 1 file
vulcanize index.html > build.html
# move back below the repo
cd ../../..
# support for updating ELMSLN copy of this
cp build/build/default/build.html ~/elmsln/core/dslmcode/shared/drupal-7.x/libraries/webcomponents/polymer/LRNWebcomponents/build.html
cp build/build/default/push-manifest.json ~/elmsln/core/dslmcode/shared/drupal-7.x/libraries/webcomponents/polymer/LRNWebcomponents/manifest.json
cp build/build/default/service-worker.js ~/elmsln/core/dslmcode/shared/drupal-7.x/libraries/webcomponents/polymer/LRNWebcomponents/service-worker.js

cp build-for-edit/build/default/build.html ~/elmsln/core/dslmcode/shared/drupal-7.x/modules/elmsln_contrib/cis_connector/modules/features/elmsln_core/LRNWebComponents/build_edit.html

echo "$repo as well as the LRN build file have been updated"