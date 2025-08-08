pipeline {
    agent any

    environment {
        IMAGE_NAME = 'flutter-web-app'
        CONTAINER_NAME = 'flutter-web-container'
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📥 Kod GitHub\'dan dev branch\'ten çekiliyor...'
                git branch: 'dev', url: 'https://github.com/ozkzrl/ozkzrl-flutter-docker-jenkins-pipeline.git'
            }
        }

        stage('Flutter Analyze & Test') {
            steps {
                echo '🔍 Flutter bağımlılıkları çekiliyor, analiz ve test çalıştırılıyor...'
                sh '''
                    flutter pub get
                    flutter analyze
                    flutter test
                '''
            }
        }

        stage('Build Flutter Web') {
            steps {
                echo '🛠️ Flutter web uygulaması derleniyor...'
                sh 'flutter build web'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Docker imajı build ediliyor (Flutter web için)...'
                sh 'docker build -t $IMAGE_NAME -f Dockerfile.flutter .'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo '🚀 Docker container başlatılıyor...'
                sh '''
                    docker stop $CONTAINER_NAME || echo "Zaten durmuş"
                    docker rm $CONTAINER_NAME || echo "Zaten silinmiş"
                    docker run -d -p 8082:80 --name $CONTAINER_NAME $IMAGE_NAME
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline başarıyla tamamlandı.'
        }
        failure {
            echo '❌ Pipeline başarısız oldu!'
        }
    }
}
