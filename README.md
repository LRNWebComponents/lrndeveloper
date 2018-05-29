# LRNdeveloper

## Docker workflow

Install Docker from the official Docker website. Either [Docker for Mac](https://www.docker.com/docker-mac) or [Docker for Windows](https://www.docker.com/docker-windows).  Once Docker has been installed, open the application to allow it to run.

Verify that you have Docker installed by running:
```
docker
cd lrndeveloper
make start
make connect
# from inside the docker image
lrndev
```

Install Git from [https://git-scm.com/](https://git-scm.com/)

Verify that you have Git installed by running:
```
git
```

Developer tools which will help you build [Polymer](https://www.polymer-project.org/)-based [LRN](https://www.webcomponents.org/author/LRNWebComponents) Components even faster, as well as streamlining installation issues associated with dependencies on your computer. If you get any errors about permissions along the way you may need administrative permissions on your machine.

## How to use this from scratch

1. Create a directory on your computer where you'd like to install this project, for example:

```
cd ~/ && mkdir -p Documents/git/elmsln/LRNWebComponents/ && cd Documents/git/elmsln/LRNWebComponents/ 
```
2. Copy the LRNdeveloper project into the new directory

```
curl -s https://api.github.com/orgs/LRNWebComponents/repos?per_page=200 | ruby -rubygems -e 'require "json"; JSON.load(STDIN.read).each { |repo| %x[git clone \"#{repo["html_url"]}\" ]}' && cd lrndeveloper
```

### Install Node
Go to https://nodejs.org/en/ and install the 6.x+ LTS release.

### (Optional) I don't have Polymer/ Bower/ NPM setup though

1. No problem! Drill into the directory where you installed this project

```
cd ~/Documents/git/elmsln/LRNWebComponents/lrndeveloper
```

2. Then run this setup script
```sudo sh osx-setup.sh```

## Creating a shortcut for the LRNdev tool in your Command Line Interface
To create a handy shortcut, go into your CLI and type the following, ensuring that the path below matches wherever you installed this project:
```
echo "alias lrndev='bash ~/Documents/git/elmsln/LRNWebComponents/lrndeveloper/lrndev.sh'" >> ~/.bash_profile && source ~/.bash_profile
```

Now you can run the CLI by typing `lrndev` from anywhere and step through the prompts.

After this, to build a new component for lrn, start in the project directory:
```
cd ~/Documents/git/elmsln/LRNWebComponents/lrndeveloper/
```
And run the following command to create a new element, which [must contain at least one dash](https://www.webcomponents.org/community/articles/how-should-i-name-my-element). In this example, `my-cool-component` is the name of your new LRN element. This could be lrn-whatever, lrndesign-whatever, hax-whatever, or lrnsys-whatever.

```
sh lrn.sh my-cool-component
```
This script will:
- Build a directory for this location by copying a boilerplate element.
- Name everything in this component properly.
- Create a new git repo / put everything produced under version control via Git.
- Do a `polymer serve --open` to give you a mini serve instance to see what it made

From here, it's your responsibility to build something awesome for education. Make us great!

Looking for a demo? Please check out this [YouTube video](https://www.youtube.com/watch?v=P-ZA4CQASpY&t=2119s) to see this tool in action.

## Using Docker

Build Image

```
$ docker build -t lrndeveloper .
```

Start Container

```
$ docker run -it --rm -v $(pwd):/home/node/html lrndeveloper bash
```

Serve From Container

```
$ docker run -it --rm -v $(pwd):/home/node/html -p 8081:8081 lrndeveloper
```

If Docker says that an existing port is already taken then stop all other containers.

```
$ docker stop $(docker ps -a -q)
```