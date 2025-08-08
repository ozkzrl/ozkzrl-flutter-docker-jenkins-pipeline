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

RUN git clone https://github.com/flutter/flutter.git /opt/flutter

RUN git config --global --add safe.directory /opt/flutter

RUN chown -R jenkins:jenkins /opt/flutter

RUN chmod -R u+rwX /opt/flutter/bin/cache

RUN groupadd -f docker && usermod -aG docker jenkins

ENV FLUTTER_HOME="/opt/flutter"
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

USER jenkins

RUN flutter --version
RUN flutter precache --web
