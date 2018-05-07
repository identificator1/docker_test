FROM openjdk:8-jdk

####
USER root:root
####

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

RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y lib32z1 libc6:i386 libncurses5:i386 libstdc++6:i386 expect
    
ENV GRADLE_VERSION 4.4
ENV ANDROID_SDK_VERSION 3859397
ENV ANDROID_SDK_PATH /usr/local/bin/android-sdk
ENV ANDROID_API_LEVELS "platforms;android-19" "platforms;android-20" "platforms;android-21" "platforms;android-22" "platforms;android-23" "platforms;android-24" "platforms;android-25" "platforms;android-26" "platforms;android-27"

#FROM /
#COPY bin /usr/local/bin
RUN chmod 755 /usr/local/bin/docker-android-sdk-install
RUN mkdir -p ${ANDROID_SDK_PATH}

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
    unzip sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
    mv tools ${ANDROID_SDK_PATH} && \
    rm sdk-tools-linux-${ANDROID_SDK_VERSION}.zip

RUN wget https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    mkdir /opt/gradle && \
    unzip -d /opt/gradle gradle-${GRADLE_VERSION}-bin.zip && \
    rm gradle-${GRADLE_VERSION}-bin.zip

ENV ANDROID_HOME /usr/local/bin/android-sdk
ENV PATH $PATH:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:/opt/gradle/gradle-${GRADLE_VERSION}/bin

RUN mkdir ~/.android && touch ~/.android/repositories.cfg

RUN docker-android-sdk-install "platform-tools" ${ANDROID_API_LEVELS}

RUN rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean

####
USER ${user}:${user}
####
ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /home/${user}/.jenkins && mkdir -p ${AGENT_WORKDIR}
VOLUME /home/${user}/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/${user}
ENV JAVA_OPTS="-Xmx8192m"
