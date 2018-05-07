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
USER ${user} 
ENV AGENT_WORKDIR=${AGENT_WORKDIR} RUN mkdir /home/${user}/.jenkins && mkdir -p ${AGENT_WORKDIR}
VOLUME /home/${user}/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/${user}
ENV GRADLE_VERSION 4.4
ENV ANDROID_SDK_VERSION 3859397
ENV ANDROID_SDK_PATH /usr/local/bin/android-sdk
ENV ANDROID_API_LEVELS "platforms;android-19" "platforms;android-20" "platforms;android-21" "platforms;android-22" "platforms;android-23" "platforms;android-24" "platforms;android-25" "platforms;android-26" "platforms;android-27"
