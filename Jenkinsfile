pipeline {
    agent any
    stages {
        stage('Pretest') {
            agent { label 'docker'}
            steps {
                echo 'Local hostname is'
                sh "hostname"
                //sh "docker build . -t temp:latest"
            }
        }
        stage('Build using plugin') {
            agent { dockerfile true }
            steps {
                sh "pwd && ls"
                sh "git clone https://github.com/codepath/intro_android_demo && cd intro_android_demo && ls && ./gradlew test"
                //sh "./gradlew tasks"
            }
        } 
    }
}
