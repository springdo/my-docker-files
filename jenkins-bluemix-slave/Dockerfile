FROM node-bluemix-vanilla
MAINTAINER Donal Spring <donal@uk.ibm.com>

RUN mkdir /var/run/sshd
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/ssh/sshd_config
RUN sed -i 's|PasswordAuthentication no|PasswordAuthentication yes|g' /etc/ssh/sshd_config

# password is jenkins
RUN useradd --uid=1099 -p dW7IzpQGfPQtY -ms /bin/bash jenkins
ENV JENKINS_HOME /home/jenkins
RUN mkdir -p ${JENKINS_HOME}/.ssh
RUN chown -R jenkins:jenkins ${JENKINS_HOME}

# Add Keys when needed
#ADD id_rsa.pub ${JENKINS_HOME}/.ssh/authorized_keys
#RUN chmod 700 ${JENKINS_HOME}/.ssh
#RUN chmod 600 ${JENKINS_HOME}/.ssh/authorized_keys


EXPOSE 22

#RUN ufw allow from 86.6.45.94 to any port 4243
#RUN ufw allow from 195.212.29.94

# ensure git config is setup
RUN git config --global user.email "jenkins@jenkins.ci"
RUN git config --global user.name "jenkins"

#Starts the ssh daemon (without this you cannot ssh to this container)
CMD ["/usr/sbin/sshd", "-D"]