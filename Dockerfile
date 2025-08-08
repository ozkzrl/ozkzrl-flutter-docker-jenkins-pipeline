FROM jenkins/jenkins:lts

USER root

# Gerekli paketlerin kurulumu
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

# Güvenli dizin olarak işaretle
RUN git config --global --add safe.directory /opt/flutter

# Flutter dizin ve cache izinlerini düzelt
RUN chown -R jenkins:jenkins /opt/flutter && \
    chmod -R u+rwX /opt/flutter/bin/cache

# Jenkins kullanıcısını docker grubuna ekle
RUN groupadd -f docker && usermod -aG docker jenkins

# Ortam değişkenleri
ENV FLUTTER_HOME="/opt/flutter"
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

USER jenkins

# Flutter versiyonu kontrolü ve önbellek
RUN flutter --version
RUN flutter precache --web
