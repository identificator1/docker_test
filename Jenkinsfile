pipeline {
    agent { label 'docker'}
    stages {
        stage('Pretest') {
            steps {
                sh "pwd"
            }
        }
        stage('Build') {
            agent { dockerfile true }
            steps {
                echo 'I am in docker'
                sh "hostname"
            }
        } 
    }
}
