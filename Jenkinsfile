pipeline {
    agent { label 'docker'}
    stages {
        stage('Pretest') {
            steps {
                echo 'Local hostname is'
                sh "hostname"
            }
        }
        stage('Build') {
            agent { dockerfile true }
            steps {
                echo 'I am in a docker container, its hostname is'
                sh "hostname"
                sh "rm -rf intro_android_demo"
                sh "git clone https://github.com/codepath/intro_android_demo && cd intro_android_demo"
                sh "android list sdk -a -e"
                sh "gradlew tasks"
                //sh "./gradlew build"
            }
        } 
    }
}
