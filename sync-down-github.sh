#!/bin/bash
# pull all repos

cd ~/ && mkdir -p Documents/git/elmsln/LRNWebComponents/ && cd Documents/git/elmsln/LRNWebComponents/ && curl -s https://api.github.com/orgs/LRNWebComponents/repos?per_page=200 | ruby -rubygems -e 'require "json"; JSON.load(STDIN.read).each { |repo| %x[git clone \"#{repo["html_url"]}\" ]}' && cd lrndeveloper

echo "All the webcomponent repos have been pulled down."