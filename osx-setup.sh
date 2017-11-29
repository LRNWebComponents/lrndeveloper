#!/bin/bash
# Prime a system for polymer development; this works on OSX

# where am i? move to where I am. This ensures source is properly sourced
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

# shortcut to lrndev cli
echo "alias lrndev='bash ~/Documents/git/elmsln/LRNWebComponents/lrndeveloper/lrndev.sh'" >> ~/.bash_profile
# install node
echo 'export PATH=$HOME/local/bin:$PATH' >> ~/.bash_profile
source ~/.bash_profile
mkdir ~/local
mkdir ~/node-js
cd ~/node-js
curl http://nodejs.org/dist/node-v0.4.7.tar.gz | tar xz --strip-components=1
./configure --prefix=~/local --without-ssl
make install
# install npm
curl http://npmjs.org/install.sh | sh
# install bower
npm install -g bower
# install polymer
npm install -g polymer-cli

echo "Your system should now have nodejs, npm, bower and polymer all ready to go!"
