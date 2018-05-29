FROM node:8
# Sane defaults for setting up users
# https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md#global-npm-dependencies
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
RUN apt-get update
RUN apt-get install vim --yes
RUN apt-get install git --yes
RUN yarn global add polymer-cli
RUN yarn global add bower
# USER node
USER node
WORKDIR /home/node
# Install LRN Developer
RUN git clone https://github.com/LRNWebComponents/lrndeveloper.git /home/node/lrndeveloper
RUN echo "alias lrndev='bash /home/node/lrndeveloper/docker-lrndev.sh'" >> ~/.bashrc
RUN echo "export PATH='$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH'" >> ~/.bashrc
WORKDIR /home/node/html
USER root
RUN chown node:node /home/node/html
USER node
CMD [ "polymer", "serve", "-H", "0.0.0.0", "-p", "8081" ]
EXPOSE 8081