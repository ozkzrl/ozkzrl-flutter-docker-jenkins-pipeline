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

# PATH ayarları için ENV
ENV FLUTTER_HOME="/opt/flutter"
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

# Flutter cache'i root kullanıcısı ile oluştur
RUN flutter --version
RUN flutter precache --web

# Flutter dosyalarının sahibi jenkins kullanıcısı olsun
RUN chown -R jenkins:jenkins /opt/flutter

# Jenkins kullanıcısını docker grubuna ekle
RUN groupadd -f docker && usermod -aG docker jenkins

USER jenkins

# Jenkins kullanıcısı altında Flutter kontrolü (isteğe bağlı)
RUN flutter --version
