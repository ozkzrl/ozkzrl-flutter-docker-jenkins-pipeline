pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile'
            dir '.'         // Dockerfile'ın olduğu dizin
        
        }
    }

    environment {
        FLUTTER_HOME = "/opt/flutter"
        PATH = "${env.FLUTTER_HOME}/bin:${env.PATH}"
        DEPLOY_DIR = "/var/www/html"  // Local deploy klasörün
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/kullanici/flutter-projeniz.git'  // Kendi repo URL'in
            }
        }

        stage('Flutter Clean') {
            steps {
                sh 'flutter clean'
            }
        }

        stage('Flutter Pub Get') {
            steps {
                sh 'flutter pub get'
            }
        }

        stage('Flutter Analyze') {
            steps {
                sh 'flutter analyze'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'flutter test'
            }
        }

        stage('Flutter Build Web') {
            steps {
                sh 'flutter build web'
            }
        }

        stage('Deploy to Local Server') {
            steps {
                echo 'Deploy aşaması başlıyor...'

                // build/web içeriğini deploy dizinine kopyala
                sh "cp -r build/web/* ${DEPLOY_DIR}/"
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline başarıyla tamamlandı.'
        }
        failure {
            echo '❌ Pipeline bir hata ile karşılaştı.'
        }
    }
}
