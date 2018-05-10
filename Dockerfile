FROM ubuntu:18.04

USER root:root

ARG user=jenkins
ARG group=jenkins
ARG gradleversion=3.4.1

RUN groupadd -r ${user} && useradd --no-log-init -r -g ${user} ${user}
RUN mkdir /var/log/${user}
RUN mkdir /var/cache/${user}
RUN chown -R ${user}:${group} /var/log/${user}
RUN chown -R ${user}:${group} /var/cache/${user}

RUN apt-get update && apt-get install -y apt-transport-https git curl wget openjdk-8-jdk
RUN apt-get -q -y install lsof

RUN wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz -O /opt/android-sdk.tgz
RUN tar zxvf /opt/android-sdk.tgz -C /opt/
RUN rm /opt/android-sdk.tgz

RUN wget https://services.gradle.org/distributions/gradle-${gradleversion}-bin.zip
RUN pwd && ls
RUN mkdir /opt/gradle
RUN unzip -d /opt/gradle gradle-${gradleversion}-bin.zip

RUN >/etc/profile.d/android.sh
RUN sed -i '$ a\export ANDROID_HOME="/opt/android-sdk-linux"' /etc/profile.d/android.sh
RUN sed -i '$ a\export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:/opt/gradle/gradle-${gradleversion}/bin:$PATH"' /etc/profile.d/android.sh
RUN . /etc/profile
RUN ( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | /opt/android-sdk-linux/tools/android update sdk --no-ui --filter platform-tools,android-24,build-tools-24.0.1,tools,extra-android-support,extra-android-m2repository
RUN chmod -R 755 /opt/android-sdk-linux
RUN dpkg --add-architecture i386
ENV JAVA_OPTS="-Xmx8192m"
