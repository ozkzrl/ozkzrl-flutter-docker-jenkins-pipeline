pipeline {
    agent any

    environment {
        FLUTTER_HOME = "/opt/flutter"
        PATH = "${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "📦 Kaynak kod çekiliyor..."
                checkout scm
            }
        }

        stage('Analyze') {
            steps {
                echo "🔍 Kod analizi başlatılıyor..."
                sh 'git config --global --add safe.directory /opt/flutter'
                sh 'chmod -R u+rwX /opt/flutter/bin/cache'
                sh 'flutter analyze'
            }
        }

        stage('Test') {
            steps {
                echo "🧪 Testler çalıştırılıyor..."
                sh 'flutter test'
            }
        }

        stage('Build Web') {
            steps {
                echo "🏗️ Web için build alınıyor..."
                sh 'flutter build web'
            }
        }

        stage('Deploy') {
            steps {
                echo "🚀 Deploy işlemi başlatılıyor..."
                // build/web klasörünü 5000 portunda serve et
                sh 'cd build/web && nohup python3 -m http.server 5000 &'
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline başarıyla tamamlandı! Projeye http://localhost:5000 üzerinden ulaşabilirsiniz."
        }
        failure {
            echo "❌ Pipeline başarısız oldu. Logları kontrol edin."
        }
    }
}
