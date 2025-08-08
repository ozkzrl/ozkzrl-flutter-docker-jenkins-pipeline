FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    docker.io \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && apt-get clean

# Flutter SDK'yı indir ve güvenli dizin olarak ekle
RUN git clone https://github.com/flutter/flutter.git /opt/flutter \
    && git config --global --add safe.directory /opt/flutter

# Sahiplik ve izinleri ayarla (önce root olarak)
RUN chown -R jenkins:jenkins /opt/flutter && chmod -R u+rwX /opt/flutter

ENV FLUTTER_HOME="/opt/flutter"
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

RUN groupadd -f docker && usermod -aG docker jenkins

USER jenkins

# Flutter versiyon kontrolü ve önbellek oluşturma
RUN flutter --version && flutter precache --web
