# Taban görüntü olarak Jenkins LTS kullan
FROM jenkins/jenkins:lts

# Root kullanıcıya geç
USER root

# Gerekli sistem paketlerini kur (Flutter, Android ve Docker için)
RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils zip libglu1-mesa openjdk-17-jdk docker.io \
    && apt-get clean

# Android SDK ortam değişkenlerini ayarla
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# Android SDK klasörünü oluştur ve yetkileri ayarla
RUN mkdir -p ${ANDROID_HOME} && chown -R jenkins:jenkins ${ANDROID_HOME}

# Flutter kurulum ayarları
ENV FLUTTER_VERSION=3.13.9
ENV FLUTTER_HOME=/opt/flutter
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

# Flutter'ı indir ve kur
RUN git clone https://github.com/flutter/flutter.git -b stable ${FLUTTER_HOME} \
    && ${FLUTTER_HOME}/bin/flutter doctor

# Flutter klasörüne jenkins yetkisi ver
RUN chown -R jenkins:jenkins ${FLUTTER_HOME}

# Jenkins kullanıcısına Docker kullanma yetkisi ver (opsiyonel ama faydalı)
RUN usermod -aG docker jenkins

# Jenkins kullanıcısına geri dön
USER jenkins

# Flutter'ı doğrula (önbelleği oluşturur)
RUN flutter doctor -v
