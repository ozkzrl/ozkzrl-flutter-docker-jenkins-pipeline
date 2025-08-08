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

# Flutter SDK'yı indir
RUN git clone https://github.com/flutter/flutter.git /opt/flutter

ENV FLUTTER_HOME="/opt/flutter"
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

# Flutter SDK cache'i root ile oluştur
RUN flutter precache --web

# Cache içindeki engine.stamp ve diğer dosyalara yazma izinleri verelim (recursive)
RUN chmod -R u+rwX /opt/flutter/bin/cache

# Flutter dosyalarının sahibi jenkins kullanıcısı olsun
RUN chown -R jenkins:jenkins /opt/flutter

# Jenkins kullanıcısını docker grubuna ekle
RUN groupadd -f docker && usermod -aG docker jenkins

USER jenkins

RUN flutter --version
