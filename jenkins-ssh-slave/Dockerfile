#jenkins-ssh-slave
FROM ubuntu-base:latest
MAINTAINER Donal Spring <donal@uk.ibm.com>

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:83BvY4UfnWO' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

#3. Add user jenkins to the image
# password is jenkins
RUN useradd --uid=1099 -p dW7IzpQGfPQtY -ms /bin/bash jenkins
ENV JENKINS_HOME /home/jenkins
RUN mkdir -p ${JENKINS_HOME}/.ssh
ADD id_rsa.pub ${JENKINS_HOME}/.ssh/authorized_keys
RUN chown -R jenkins:jenkins ${JENKINS_HOME}
RUN chmod 700 ${JENKINS_HOME}/.ssh
RUN chmod 600 ${JENKINS_HOME}/.ssh/authorized_keys

CMD ["/usr/sbin/sshd", "-D"]