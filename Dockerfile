FROM jenkins/jenkins:lts

USER root

# Gerekli sistem paketleri
RUN apt-get update && apt-get install -y \
  curl git unzip xz-utils zip libglu1-mesa

# Flutter SDK kurulumu
ENV FLUTTER_VERSION=3.13.9
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

RUN git clone https://github.com/flutter/flutter.git -b stable ${FLUTTER_HOME} \
  && ${FLUTTER_HOME}/bin/flutter doctor

# Jenkins için yetkilendirme
RUN chown -R jenkins:jenkins ${FLUTTER_HOME}

USER jenkins
