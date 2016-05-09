FROM ubuntu:14.04
MAINTAINER Donal Spring <donal@uk.ibm.com>
# Old version stuff, left here for memories
#FROM registry.eu-gb.bluemix.net/ibmnode:latest
#FROM node:0.12-onbuild

RUN apt-get update
RUN apt-get -y upgrade
# Using separate lines to split out each install to keep docker deltas
RUN apt-get install -y openjdk-7-jdk \
	openssh-server \
	ufw \
	wget \
	curl \
	git-core \
	jq 

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash
RUN apt-get install -y nodejs libfontconfig

# Fix node and npm versions
# npm - 3.3.12
# node - 5.3.0
RUN npm install -g n
RUN n stable
RUN n 0.12.7
RUN node -v
RUN npm -v

RUN ls -la
RUN wget http://go-cli.s3-website-us-east-1.amazonaws.com/releases/v6.12.4/cf-cli_amd64.deb
RUN dpkg -i cf-cli_amd64.deb
RUN cf install-plugin https://static-ice.ng.bluemix.net/ibm-containers-linux_x64

RUN npm install -g grunt-cli grunt 
RUN npm install -g bower 
RUN npm install -g npm-cache 
RUN npm install -g yo
RUN npm install -g istanbul
