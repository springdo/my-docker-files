FROM ubuntu:14.04
MAINTAINER Donal Spring <donal@uk.ibm.com>

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y software-properties-common
RUN apt-get install -y \
	curl \
	git \
	jq \
	wget

RUN ln -sf /bin/bash /bin/sh