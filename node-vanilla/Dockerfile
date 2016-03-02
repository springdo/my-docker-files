FROM jenkins-ssh-slave 
MAINTAINER Donal Spring <donal@uk.ibm.com>

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash
RUN apt-get install -y nodejs libfontconfig

# Fix node and npm versions
# npm - 3.3.12
# node - 5.3.0
RUN npm install -g n
RUN n stable
RUN n 5.3.0
RUN node -v
RUN npm -v

# Install bower, grunt and yo
RUN npm install -g bower grunt grunt-cli yo gulp
RUN npm install -g npm-cache
