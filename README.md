# lrndeveloper
A repo for developer tools to build lrn polymer elements even faster then stock as well as helping streamline installation issues associated with dependencies on your computer to do so.

## How to use this from nothing
copy and paste the following and it'll do everything you need to get started as a lrn developer
`cd ~/ && mkdir -p Documents/git/elmsln/LRNWebComponents/ && cd Documents/git/elmsln/LRNWebComponents/ && curl -s https://api.github.com/orgs/LRNWebComponents/repos?per_page=200 | ruby -rubygems -e 'require "json"; JSON.load(STDIN.read).each { |repo| %x[git clone \"#{repo["html_url"]}\" ]}' && cd lrndeveloper`

### (optional) I don't have polymer/bower/npm setup though
No problem, we have a one-line for fixing this
`cd ~/Documents/git/elmsln/LRNWebComponents/lrndeveloper && sudo sh osx-setup.sh`

After this, to build a new component for lrn type the following:
`cd ~/Documents/git/elmsln/LRNWebComponents/lrndeveloper/ && sh lrn.sh element-name` where element-name is the name of your new lrn element. This could be lrn-whatever, lrndesign-whatever, hax-whatever, or lrnsys-whatever. The point is that this will then
- Build a directory for this location by copying a boilerplate element
- rewrite everything to be the right name
- make a new git repo / put everything produced in version control
- do a polymer serve --open to give you a mini serve instance to see what it made

From here, it's your responsibility to build something awesome for education. Make us great!
