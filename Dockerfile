FROM jenkins/jenkins:lts

USER root

# Gerekli paketler
RUN apt-get update && apt-get install -y \
    docker.io \
    git \
    curl \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && apt-get clean

# Flutter SDK'yı indir ve güvenli dizin olarak ayarla
RUN git clone https://github.com/flutter/flutter.git /opt/flutter && \
    git config --global --add safe.directory /opt/flutter

# Flutter dizinine sahipliği jenkins kullanıcısına ver
RUN chown -R jenkins:jenkins /opt/flutter

# Cache klasörüne tam izin ver (buradaki izinler çok önemli)
RUN chmod -R u+rwX /opt/flutter/bin/cache

# Jenkins kullanıcısını docker grubuna ekle
RUN groupadd -f docker && usermod -aG docker jenkins

# Flutter PATH ayarları
ENV FLUTTER_HOME="/opt/flutter"
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

USER jenkins

# Flutter versiyon ve cache önceden oluştur (jenkins kullanıcısı olarak)
RUN flutter --version && flutter precache --web

