pipeline {
    agent { label 'docker'}
    stages {
        stage('Pretest') {
            steps {
                echo 'Local hostname is"
                sh "hostname"
            }
        }
        stage('Build') {
            agent { dockerfile true }
            steps {
                echo 'I\'m in a docker container, it\'s hostname is'
                sh "hostname"
                sh "git clone https://github.com/codepath/intro_android_demo && cd intro_android_demo"
                sh "gradlew tasks"
                //sh "./gradlew build"
            }
        } 
    }
}
