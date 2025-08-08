FROM jenkins/jenkins:lts

USER root

# Gerekli paketler (Docker CLI dahil)
RUN apt-get update && apt-get install -y \
    docker.io \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && apt-get clean

# Flutter SDK yükleme
RUN git clone https://github.com/flutter/flutter.git /opt/flutter

# Flutter PATH ayarları
ENV FLUTTER_HOME="/opt/flutter"
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

# Flutter versiyon kontrol + web için önceden cache oluşturma
RUN flutter --version && flutter precache --web

# Jenkins kullanıcısını docker grubuna ekle
RUN groupadd -for docker && usermod -aG docker jenkins

USER jenkins
