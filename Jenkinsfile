pipeline {
    agent any

    environment {
        FLUTTER_HOME = "${WORKSPACE}/flutter"
        PATH = "${FLUTTER_HOME}/bin:${PATH}"
    }

    stages {
        stage('Install Flutter') {
            steps {
                sh '''
                    git clone https://github.com/flutter/flutter.git -b stable $FLUTTER_HOME
                    flutter doctor
                '''
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

        stage('Deploy') {
            steps {
                echo 'Deploy işlemi burada yapılır.'
            }
        }
    }

    post {
        failure {
            echo '❌ Pipeline başarısız oldu.'
        }
    }
}
