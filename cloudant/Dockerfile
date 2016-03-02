# Yes, 12.04. Be 'precise'.
# Even if it's (quite) old, it's one of the two Debian-based distros officially supported by IBM for Cloudant.
# Consequence: we can't rely on Java Dockerfiles (https://github.com/dockerfile/java), as they are based on a more recent Ubuntu.
FROM ubuntu:12.04

MAINTAINER garage@fr.ibm.com

# Our Cloudant install file - Note: it's IBM licenced
ENV CLOUDANT_TGZ CLO_DLLED_1.0.0.3_LNX8664_UB,DEB_.tar.gz

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# This will avoid messages such as "unable to initialize frontend: Dialog" during package install
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install Java & other Cloudant prereqs
# We need OpenJDK 6, the only supported JDK for Cloudant.
# NOTE: if you find yourself hanging at step stuck at step Setting up ca-certificates-java", read the README.md
#       You'll need to either down/upgrade Docker or use an OverlayFS-base Docker Machine
RUN \
    apt-get update && \
    apt-get install -y \
        curl \
        geoip-database \
        libevent-2.0-5 \
        libgd2-noxpm \
        libgeoip1 \
        libicu48 \
        libmozjs185-1.0 \
        libxslt1.1 \
        lsb-release \
        nginx \
        nginx-common \
        nginx-full \
        ntp \
        openjdk-6-jdk \
        python \
        python-dev \
        python-gevent \
        python-greenlet \
        python-pip \
        python-requests \
        python-software-properties \
        rsync \
        rsyslog \
        runit \
        software-properties-common \
        sudo && \
    pip install -I  requests==2.7.0 \
                    semantic-version==2.4.1    

# Note: 'ADD' unpacks tgz files
ADD cloudant-install/${CLOUDANT_TGZ} /cloudant-install/
WORKDIR /cloudant-install

# Here we unpack install packages and install them - beforehand we'll prepare the configure script to run at startup
# We're also faking the enableports.sh script which is useless in Docker context
# Note: you *must* specify a "friendly" hostname when starting your container (-h option)
#       Cloudant will fail with Docker default hostnames such as '10fae66590'
RUN \
    echo "Unpacking Cloudant..." && \
    ./quiet_install.sh -a -s -n -x && \
    echo "Installing Cloudant..." && \
    /root/Cloudant/repo/install.sh -q

ADD cloudant-install/configure.ini.single.template /
ADD cloudant-install/configure-service.sh /etc/sv/cloudant-configure/run

# OK, it's another RUN while we *should* minimize them
# But we'd like to have the previous one cached in case we need to re-build container image
# We create the configuration service that will actually do the cloudant configuration on startup
# We also neutralize the port enablement step - useless in our Docker environment
RUN \
    chmod 755 /etc/sv/cloudant-configure/run && ln -s /etc/sv/cloudant-configure /etc/service && \
    cp /root/Cloudant/repo/enableports.sh /root/Cloudant/repo/enableports-orig.sh && \
    echo "echo \"This is a stubbed version of enableports.sh for Docker install\"\nexit 0" > /root/Cloudant/repo/enableports.sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /cloudant-install && \
    echo "Completed. Start the container with: docker run -h cloudant -d -p 80:80 <containerId>"
    
# You may want to enable 443 - or not. It's a dev container after all.
EXPOSE 80

# Our main process is the runit one 
# This is a good practice to have a container made of multiple services - like this one
CMD /usr/sbin/runsvdir-start