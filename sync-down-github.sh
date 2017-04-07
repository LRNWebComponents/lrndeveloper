#!/bin/bash
# pull all repos

# where am i? move to where I am. This ensures source is properly sourced
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
# go back a level so we have all the repos here
cd ../
curl -s https://api.github.com/orgs/LRNWebComponents/repos?per_page=200 | ruby -rubygems -e 'require "json"; JSON.load(STDIN.read).each { |repo| %x[git clone \"#{repo["html_url"]}\" ]}' && cd lrndeveloper

echo "All the webcomponent repos have been pulled down."