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

ENV FLUTTER_HOME="/opt/flutter"
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

# Flutter klasöründeki tüm dosya ve alt dizinlerin sahipliğini ve izinlerini değiştir
RUN chown -R jenkins:jenkins /opt/flutter && \
    chmod -R u+rwX /opt/flutter

RUN groupadd -f docker && usermod -aG docker jenkins

USER jenkins

# Flutter cache'i ve sürümü bu kullanıcı altında oluştur
RUN flutter --version && flutter precache --web
