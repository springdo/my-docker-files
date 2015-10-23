FROM registry.eu-gb.bluemix.net/my_containers/node-vanilla:latest
MAINTAINER Donal Spring <donal@uk.ibm.com>

RUN cat /etc/ssh/sshd_config
#RUN cat /etc/pam.d/sshd
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/ssh/sshd_config
#RUN cat /etc/pam.d/sshd

#RUN adduser jenkins
#RUN echo "jenkins:jenkins" | chpasswd
RUN sed -i 's|PasswordAuthentication no|PasswordAuthentication yes|g' /etc/ssh/sshd_config
RUN useradd -p dW7IzpQGfPQtY -ms /bin/bash jenkins

EXPOSE 22

#RUN ufw allow from 86.6.45.94 to any port 4243
#RUN ufw allow from 195.212.29.94


# Checking the versions against the configured ones in node-vanilla
RUN node -v
RUN npm -v

CMD ["/usr/bin/supervisord", "-n"]
