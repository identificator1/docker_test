pipeline {
    agent { label 'docker'}
    stages {
        stage('Pretest') {
            steps {
                echo 'Local hostname is'
                sh "hostname"
                sh "touch host.txt"
            }
        }
        stage('Build') {
            agent { dockerfile true }
            steps {
                echo 'I am in a docker container, its hostname is'
                sh "hostname"
                sh "ls"
                sh "git clone https://github.com/codepath/intro_android_demo && cd intro_android_demo"
                sh "gradlew tasks"
                //sh "./gradlew build"
            }
        } 
    }
}
