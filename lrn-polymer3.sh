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

# execute the wcf command of much happiness, specific to me but meh
wcf element --name=${project} --description="Automated conversion of ${project}" --factory=/Users/bto108/Documents/git/elmsln/company/factories/lrnwebcomponents --customElementTemplate=Polymer --no-useSass --no-addProps --useHAX
# add a library directory since we'll use this for multiple elements in a repo
mkdir -p company/factories/lrnwebcomponents/elements/${project}/lib
# now upgrade the module
cd ../lrnwebcomponents/${project}
# requirement from docs
bower install
# convert it initially which assumes this is the start of the 0.0.1 version, lerna will correct this
modulizer --out ../../company/factories/lrnwebcomponents/elements/${project}/lib --npm-name @lrnwebcomponents/${project} --npm-version 0.0.1 --force --import-style name
# move back over to monorepo and commit
cd ../../company/factories/lrnwebcomponents/
git add -A
git commit -m "automated modulizer starting point for ${project}"
lrnwarn "Next steps:"
lrnecho "cd /Users/bto108/Documents/git/elmsln/company/factories/lrnwebcomponents/${project}"
lrnecho "1. manually resolve lib/package.json dependencies"
lrnecho "2. delete lib/test/"
lrnecho "3. delete lib/index.html"
lrnecho "4. resolve lib/${project}.js with src/${project}.js"
lrnecho "5. optional: add in tooling line as needed for hax, html and properties as it makes sense"
lrnecho "6. optional: upgrade from Polymer 1.x.x global object methodology to OOP methodology"
lrnecho "7. yarn run dev and resolve issues"
lrnecho "8. yarn run build"