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
    python3 \
    python3-pip \
    && apt-get clean

# Flutter SDK'yı indir
RUN git clone https://github.com/flutter/flutter.git /opt/flutter

ENV FLUTTER_HOME="/opt/flutter"
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

# Flutter cache dosyalarını oluştur (web dahil)
RUN /opt/flutter/bin/flutter precache --web

# Cache içindeki dosyalara yazma izinleri verelim
RUN chmod -R u+rwX /opt/flutter/bin/cache

# Flutter dosyalarının sahibi jenkins kullanıcısı olsun
RUN chown -R jenkins:jenkins /opt/flutter

# Jenkins kullanıcısını docker grubuna ekle
RUN groupadd -f docker && usermod -aG docker jenkins

# Basit bir Python HTTP server ile build/web klasörünü 5000 portundan servis edeceğiz
USER jenkins
WORKDIR /var/jenkins_home

# Container başlatıldığında hem Jenkins hem de Flutter Web server çalışsın
CMD bash -c "jenkins.sh & python3 -m http.server --directory /var/jenkins_home/workspace/flutter-pipeli-container/build/web 5000"
