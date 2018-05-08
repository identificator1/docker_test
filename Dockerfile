FROM ubuntu:18.04

USER root:root

RUN apt-get update && apt-get install -y git curl wget && rm -rf /var/lib/apt/lists/*

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG http_port=8080
ARG agent_port=50000

ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}

# Jenkins is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN groupadd -g ${gid} ${group} \
    && useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

# Jenkins home directory is a volume, so configuration and build history
# can be persisted and survive image upgrades
VOLUME /var/jenkins_home


# could use ADD but this one does not check Last-Modified header neither does it allow to control checksum
# see https://github.com/docker/docker/issues/8331
ENV JENKINS_UC https://updates.jenkins.io
ENV JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental


####

RUN mkdir /var/log/${user}
RUN mkdir /var/cache/${user}
RUN chown -R ${user}:${user} /var/log/${user}
RUN chown -R ${user}:${user} /var/cache/${user}
 
RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-get -q -y install lsof
 
RUN wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz -O /opt/android-sdk.tgz
RUN tar zxvf /opt/android-sdk.tgz -C /opt/
RUN rm /opt/android-sdk.tgz
 
RUN >/etc/profile.d/android.sh
RUN sed -i '$ a\export ANDROID_HOME="/opt/android-sdk-linux"' /etc/profile.d/android.sh
RUN sed -i '$ a\export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"' /etc/profile.d/android.sh
RUN . /etc/profile
RUN apt-get install git-core
RUN ( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | /opt/android-sdk-linux/tools/android update sdk --no-ui --filter platform-tools,android-24,build-tools-24.0.1,tools,extra-android-support,extra-android-m2repository
RUN chmod -R 755 /opt/android-sdk-linux
RUN dpkg --add-architecture i386
USER ${user}:${user}
ENV JAVA_OPTS="-Xmx8192m"
