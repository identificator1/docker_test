pipeline {
    agent { label 'docker'}
    stages {
        stage('Pretest') {
            steps {
                sh "pwd"
            }
        }
        stage('Build') {
            agent { docker 'jacekmarchwicki/android'}
            steps {
                echo 'I am in docker'
                sh "hostname"
                sh "docker container ls"
            }
        } 
    }
}
