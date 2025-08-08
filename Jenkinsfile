pipeline {
    agent {
        docker {
            image 'seninkullaniciad/fluter-jenkins-agent' // Docker Hub’a push’ladıysan
            args '-v /var/run/docker.sock:/var/run/docker.sock' // Docker build için gerekli
        }
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📥 Kod çekiliyor...'
                git branch: 'dev', url: 'https://github.com/ozkzrl/ozkzrl-flutter-docker-jenkins-pipeline.git'
            }
        }

        stage('Flutter Analyze & Test') {
            steps {
                echo '🔍 Flutter test ve analiz...'
                sh '''
                    flutter pub get
                    flutter analyze
                    flutter test
                '''
            }
        }

        stage('Build Flutter Web') {
            steps {
                echo '🛠️ Web build...'
                sh 'flutter build web'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Docker image...'
                sh 'docker build -t flutter-web-app -f Dockerfile.flutter .'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo '🚀 Docker çalıştırılıyor...'
                sh '''
                    docker stop flutter-web-container || true
                    docker rm flutter-web-container || true
                    docker run -d -p 8082:80 --name flutter-web-container flutter-web-app
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Başarıyla tamamlandı.'
        }
        failure {
            echo '❌ Pipeline başarısız!'
        }
    }
}
