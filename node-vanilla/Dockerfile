FROM registry.eu-gb.bluemix.net/ibmnode:latest
MAINTAINER Donal Spring <donal@uk.ibm.com>

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y openjdk-7-jdk
RUN apt-get install -y openssh-server

RUN npm install -g grunt-cli grunt bower 
