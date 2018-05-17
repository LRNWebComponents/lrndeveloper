#!/bin/sh
# lrndev.sh is intended to be an interactive prompt for building lrn components
# and optimizing efficency of development

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

# prompt the user
prompt="LRNDev: Type the number for what you'd like to do today: "
items=("oops, didn't want to be here" "build a new component" "build a one page app" "serve the files for an element")
locations=('' 'docker-lrn.sh' 'docker-lrn-opa.sh' 'serve -H 0.0.0.0 -p 8081 --open')
commands=('' 'sh' 'sh' 'polymer')

# render the menu options
menuitems() {
  lrnecho "Hi I'm LRNDev, here to help you take education further, faster. What can I help you do today? "
  for i in ${!items[@]}; do
    echo $((i))") ${items[i]}"
  done
  [[ "$msg" ]] && echo "" && echo "$msg"; :
}
# make sure we get a valid response before doing anything
while menuitems && read -rp "$prompt" num && [[ "$num" ]]; do
  (( num > 0 && num <= ${#items[@]} )) || {
    if [ $num == 0 ]; then
      lrnwarn 'LRNDev: See ya later!'
      exit
    fi
    msg="LRNDev: $num is not a valid option, try again."; continue
  }
  # if we got here it means we have valid input
  choice="${items[num]}"
  if [ "${locations[num]}" == '' ]; then
    location=''
  else
    location="${locations[num]}"
  fi
  cmd="${commands[num]}"
  lrnecho "LRNDev: $choice ($cmd $location)"
  $cmd $location
done