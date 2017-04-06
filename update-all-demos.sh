#!/bin/bash
# This will walk into each directory in this set and ensure it's demo is up to date
# and pushed up to github

# where am i? move to where I am. This ensures source is properly sourced
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
# go back a level so we have all the repos here
cd ../
# walk each directory and update it's demo automatically
for d in */ ; do
	# step into directory
	cd "$d"
	# make sure it's up to date
	git pull origin master
	# run the update, this might take awhile
    sh update-demo.sh
    # back out so we can do it again
    cd ..
done

echo "All the demos for your webcomponents have been updated."