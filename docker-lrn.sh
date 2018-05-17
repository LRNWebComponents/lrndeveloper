#!/bin/bash
# We build our LRN components the same way every time so this is a developer
# efficiency tool to ensure they are built and named correctly
# provide messaging colors for output to console
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
cd /home/node/html
#test for empty vars. if empty required var -- exit
prompt="Enter a valid element name to create such as lrn-name lrndesign-block lrnsys-code, etc: "
project=$1
if [ -z $1 ]; then
  lrnwarn "argument 1 is required and has to be the name of the element to make"
  lrnwarn ""
  read -rp "$prompt" project
fi
if [ -z $project ]; then
  lrnwarn "argument 1 is required and has to be the name of the element to make"
  lrnwarn ""
  exit 1
fi
# make the directory from our boilerplate
cp -R /home/node/lrndeveloper/boiler-plate $project
cd $project
# do some name clean up
mv boiler-plate.html ${project}.html

# do some rewrites inside the files
sed -ie "s/boiler-plate/${project}/g" "${project}.html"
rm "${project}.htmle"
sed -ie "s/boiler-plate/${project}/g" update-demo.sh
rm update-demo.she
sed -ie "s/boiler-plate/${project}/g" index.html
rm index.htmle
sed -ie "s/boiler-plate/${project}/g" bower.json
rm bower.jsone
sed -ie "s/boiler-plate/${project}/g" demo/index.html
rm demo/index.htmle
sed -ie "s/boiler-plate/${project}/g" README.md
rm README.mde

bower install
# git stuff
git init
git remote add origin "git@github.com:LRNWebComponents/${project}.git"
git add -A
git commit -m "Initial commit of ${project} element"
# this part will probably fail
git push origin master
lrnecho "if the previously step failed then go to https://github.com/organizations/LRNWebComponents/repositories/new and add a repo called ${project}"
lrnecho "enjoy your new element!"
# last step, serve it up!
polymer serve --open
