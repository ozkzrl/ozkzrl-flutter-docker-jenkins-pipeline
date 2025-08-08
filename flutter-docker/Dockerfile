FROM cirrusci/flutter:latest

# Gerekiyorsa Android SDK için path ayarları yapılabilir
ENV ANDROID_HOME=/opt/android-sdk-linux
ENV PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"

# Flutter doctor otomatik çalışsın
RUN flutter doctor

WORKDIR /usr/src/app

