FROM jenkins/jenkins:lts

USER root

# Docker'ı kur
RUN apt-get update && apt-get install -y \
    docker.io \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa

# Flutter'ı indir ve path'e ekle
RUN git clone https://github.com/flutter/flutter.git /opt/flutter \
    && /opt/flutter/bin/flutter doctor

ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Flutter doctor cache oluştur
RUN flutter precache
