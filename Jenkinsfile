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
                sh "git clone https://github.com/codepath/intro_android_demo && cd intro_android_demo"
                sh "gradlew tasks"
                //sh "./gradlew build"
            }
        } 
    }
}
