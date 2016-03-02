#Salesforce dockerfile
FROM jenkins-ssh-slave 
MAINTAINER Donal Spring <donal@uk.ibm.com>

#Update (this should also add java)
RUN apt-get update
RUN apt-get -y upgrade

#install java
RUN apt-get -y install default-jdk

#check java version
RUN java -version

RUN apt-get install -y ant

#Make sure java is installed
RUN ant -version

RUN cd /usr/share/ant/lib/ && ls -la

#RUN wget -O /home/root/downloads/force.zip https://eu6.salesforce.com/dwnld/SfdcAnt/salesforce_ant_35.0.zip
#RUN cp /root/ant-salesforce.jar /usr/share/ant/lib/ant-salesforce.jar

COPY ant-salesforce.jar /usr/share/ant/lib/
COPY ant-deploy-with-xml-report-task-1.4.jar /usr/share/ant/lib/

#Install Git
RUN apt-get -y install git
RUN git config --global user.email "jenkins@jenkins.ci"
RUN git config --global user.name "jenkins"

#Starts the ssh daemon (without this you cannot ssh to this container)
CMD ["/usr/sbin/sshd", "-D"]
