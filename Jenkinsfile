pipeline {
    agent any

    environment {
        FLUTTER_HOME = "/usr/local/flutter"
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
                // Örneğin build klasörünü bir sunucuya SCP ile atabilirsiniz
                sh 'scp -r build/web/* user@yourserver:/var/www/html'
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
