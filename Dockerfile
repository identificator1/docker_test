FROM openjdk:8-jdk

USER root:root

ARG user=jenkins
ARG group=jenkins
ARG uid=10000
ARG gid=10000
ENV HOME /home/${user}

RUN groupadd -g ${gid} ${group}
RUN useradd -c "Jenkins user" -d $HOME -u ${uid} -g ${gid} -m ${user}

LABEL Description="This is a base image, which provides the Jenkins agent executable (slave.jar)" Vendor="Jenkins project" Version="3.20"
ARG VERSION=3.20 
ARG AGENT_WORKDIR=/home/${user}/agent 
RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/${user} \
  && chmod 644 /usr/share/${user}/slave.jar
