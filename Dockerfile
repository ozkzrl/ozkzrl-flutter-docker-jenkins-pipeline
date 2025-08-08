FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    docker.io \
    git \
    curl \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && apt-get clean

# Flutter SDK'yı klonla
RUN git clone https://github.com/flutter/flutter.git /opt/flutter

# Flutter cache'i root olarak hazırla
ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter --version
RUN flutter precache --web

# Flutter dizin izinlerini Jenkins kullanıcısına ver
RUN chown -R jenkins:jenkins /opt/flutter

# Jenkins kullanıcısını docker grubuna ekle
RUN groupadd -f docker && usermod -aG docker jenkins

ENV FLUTTER_HOME="/opt/flutter"
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

USER jenkins

# Jenkins kullanıcısı altında test
RUN flutter --version
