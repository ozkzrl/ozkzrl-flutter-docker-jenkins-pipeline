FROM cirrusci/flutter:stable

# Jenkins için gerekli şeyler eklenebilir (isteğe bağlı)
RUN apt-get update && apt-get install -y git curl unzip xz-utils zip libglu1-mesa

# flutter doctor ön yükleme
RUN flutter doctor
