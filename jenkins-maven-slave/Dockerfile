#jenkins-maven-slave
FROM jenkins-ssh-slave:latest
MAINTAINER Donal Spring <donal@uk.ibm.com>

#1. Install JDK 7
RUN apt-get install -y openjdk-7-jdk --fix-missing
ENV JAVA_HOME /usr/lib/jvm/java
RUN java -version

#2. Install Maven 3.0.5
RUN apt-get install -y maven
RUN echo $PATH
RUN echo $JAVA_HOME
ENV M2_HOME /usr/share/maven
ENV M2 $M2_HOME/bin
RUN echo export M2_HOME=${M2_HOME} >> ${JENKINS_HOME}/.bash_profile
RUN echo export M2=${M2_HOME}/bin >> ${JENKINS_HOME}/.bash_profile

#3. Install Git
RUN apt-get -y install git
RUN git config --global user.email "jenkins@example.com"
RUN git config --global user.name "jenkins"




