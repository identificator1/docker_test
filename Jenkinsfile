pipeline {
    agent { label 'docker'}
    stages {
        stage('Build') {
            agent { docker 'jacekmarchwicki/android'}
            steps {
                echo 'I am in docker'
                sh "hostnamectl"
            }
        } 
    }
}
