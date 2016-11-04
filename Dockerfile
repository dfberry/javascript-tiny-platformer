#  Safe-frame test for ads
#
#
#  $ docker build -t sf-host .
#  $ docker run -h sfhost -it -p 8010:8010 -v /Users/dfberry/repos/IAB/IAB-Safeframe-Test:/home/nodejs/container-IAB-Safeframe-Test sf-host tail -f /dev/null

# Git hub: https://github.com/dfberry/IAB-Safeframe-Test
# tail -f /dev/null
#  $ docker exec -it -u root d55be534f649 /bin/bash -c "export TERM=xterm; exec bash"
#docker run -it -p 8020:8020 5014d0c951ba tail -f /dev/null

# base image 
FROM node:latest

RUN mkdir -p /home/nodejs/ && \
    groupadd -r nodejs && \
    useradd -r -g nodejs -d /home/nodejs nodejs && \
    chown -R nodejs:nodejs /home/nodejs

# add text editor
ENV TERM xterm
RUN apt-get update
RUN apt-get install nano


# add static server
RUN npm install lite-server -g

# add repository
WORKDIR /home/nodejs
RUN git clone https://github.com/dfberry/javascript-tiny-platformer.git game

WORKDIR /home/nodejs/game
USER nodejs

# export port used by safeframe hosting website
EXPOSE 8010

# make sure primary pid isn't tied to website so container will stay up
CMD tail -f /dev/null 
# CMD lite-server

