FROM jenkins/jenkins:lts

USER root

# Gerekli paketler (Flutter + Docker CLI için)
RUN apt-get update && apt-get install -y \
    docker.io \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Flutter SDK'yı indir ve kur
RUN git clone https://github.com/flutter/flutter.git /opt/flutter \
    && /opt/flutter/bin/flutter doctor

# PATH ayarları
ENV FLUTTER_HOME="/opt/flutter"
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

# Web için Flutter cache'i indir
RUN flutter precache --web

# Flutter sürüm kontrolü
RUN flutter --version

USER jenkins
