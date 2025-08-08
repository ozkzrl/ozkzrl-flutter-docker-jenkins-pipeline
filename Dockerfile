# Jenkins + Flutter SDK image
FROM jenkins/jenkins:lts

USER root

# Sistem paketleri
RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils zip libglu1-mesa openjdk-17-jdk \
    && apt-get clean

# Android SDK ortam değişkenleri (gerekirse)
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

RUN mkdir -p ${ANDROID_HOME} && chown -R jenkins:jenkins ${ANDROID_HOME}

# Flutter kurulumu
ENV FLUTTER_VERSION=3.13.9
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

RUN git clone https://github.com/flutter/flutter.git -b stable ${FLUTTER_HOME} \
    && ${FLUTTER_HOME}/bin/flutter doctor

# Jenkins kullanıcısına yetki ver
RUN chown -R jenkins:jenkins ${FLUTTER_HOME}

USER jenkins

# Flutter önbellek ve setup
RUN flutter doctor -v
