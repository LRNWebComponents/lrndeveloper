#!/bin/bash
# Run our process of converting to Polymer 3 over in RHElements
txtbld=$(tput bold)             # Bold
bldgrn=$(tput setaf 2) #  green
bldred=${txtbld}$(tput setaf 1) #  red
lrnecho(){
  echo "${bldgrn}$1${txtreset}"
}
lrnwarn(){
  echo "${bldred}$1${txtreset}"
}
# where am i? move to where I am. This ensures source is properly sourced
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
# go back a level so we have all the repos in scope
cd ../
prompt="Enter an element to upgrade: "
project=$1
if [ -z $1 ]; then
  lrnwarn "argument 1 is required and has to be the name of the element to convert"
  lrnwarn ""
  read -rp "$prompt" project
fi
if [ -z $project ]; then
  lrnwarn "argument 1 is required and has to be the name of the element to convert"
  lrnwarn ""
  exit 1
fi

cd $project
# convert it initially which assumes this is the start of the 3.0.0 version
modulizer --out . --npm-name @lrnwebcomponents/${project} --npm-version 3.0.0 --force --import-style=name
git checkout -b 3.x.x
git add -A
git commit -m "initial commit to 3.x.x branch"
git push origin 3.x.x
# now work on component factory
cd ../componentFactory/elements
yo --no-insight --no-update-notifier rhelement ${project}
npm run test-suite-inject
npm run bootstrap
rm ${project}/src/${project}.js
cp ../../${project}/${project}.js ${project}/src/${project}.js