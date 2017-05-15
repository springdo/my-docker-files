FROM mwallasch/docker-ruby-node

RUN apt-get clean && apt-get update
RUN apt-get install locales && \
  locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN gem install compass
RUN npm install -g bower grunt-cli
RUN npm install -g phantomjs-prebuilt
