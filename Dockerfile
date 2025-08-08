FROM jenkins/jenkins:lts

USER root

# Gerekli paketleri yükle
RUN apt-get update && apt-get install -y \
    docker.io \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa

# Flutter'ı indir ve kur
RUN git clone https://github.com/flutter/flutter.git /opt/flutter \
    && /opt/flutter/bin/flutter doctor

# Flutter PATH ayarları
ENV PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Flutter cache oluştur (Flutter doktorun hızlı çalışması için)
RUN flutter precache

# Tekrar Jenkins kullanıcısına dön
USER jenkins
