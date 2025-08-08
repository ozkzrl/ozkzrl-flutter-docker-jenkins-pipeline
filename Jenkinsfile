pipeline {
    agent any

    environment {
        FLUTTER_HOME = "/opt/flutter"
        PATH = "${FLUTTER_HOME}/bin:${env.PATH}"
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
                // Örnek: scp -r build/web/* user@yourserver:/var/www/html
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline başarıyla tamamlandı!"
        }
        failure {
            echo "❌ Pipeline başarısız oldu. Logları kontrol edin."
        }
    }
}
