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

# Flutter SDK'yı indir
RUN git clone https://github.com/flutter/flutter.git /opt/flutter \
    && git config --global --add safe.directory /opt/flutter

# Flutter PATH ayarları
ENV FLUTTER_HOME="/opt/flutter"
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

# Flutter klasörünün sahipliğini jenkins kullanıcısına ver ve izinleri aç
RUN chown -R jenkins:jenkins /opt/flutter && chmod -R u+rwX /opt/flutter

# Jenkins kullanıcısını docker grubuna ekle
RUN groupadd -f docker && usermod -aG docker jenkins

USER jenkins

# Flutter cache'i jenkins kullanıcısı altında oluştur
RUN flutter --version && flutter precache --web
