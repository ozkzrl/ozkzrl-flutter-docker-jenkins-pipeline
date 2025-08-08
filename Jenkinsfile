pipeline {
    agent any

    environment {
        PATH = "/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:$PATH"
    }

    stages {
        stage('Clone') {
            steps {
                checkout scm
            }
        }

        stage('Flutter Analyze') {
            steps {
                sh 'flutter pub get'
                sh 'flutter analyze'
            }
        }

        stage('Flutter Test') {
            steps {
                sh 'flutter test'
            }
        }

        stage('Flutter Build APK') {
            steps {
                sh 'flutter build apk'
            }
        }

        // İsteğe bağlı olarak deploy aşaması
        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                echo 'Deploy işlemi buraya gelecek...'
                // Örnek: scp ile başka sunucuya apk gönder
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline başarıyla tamamlandı.'
        }
        failure {
            echo '❌ Pipeline başarısız oldu.'
        }
    }
}
