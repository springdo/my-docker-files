FROM jenkins-ssh-slave:latest
MAINTAINER Donal Spring <donal@uk.ibm.com>

RUN add-apt-repository ppa:openjdk-r/ppa
RUN add-apt-repository ppa:cwchien/gradle
RUN apt-get update

#1. Install JDK 8
RUN apt-get install -y openjdk-8-jdk --fix-missing
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

#3. Install Gradle
RUN apt-get install -y gradle
ENV GRADLE_HOME /usr/lib/gradle/2.11
RUN ls -la $GRADLE_HOME
RUN echo $GRADLE_HOME
