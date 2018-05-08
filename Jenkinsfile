pipeline {
    agent { label 'docker'}
    stages {
        stage('Pretest') {
            steps {
                echo 'Local hostname is'
                sh "hostname"
                sh "docker build . -t temp:latest"
            }
        }
        stage('Build using plugin') {
            agent { dockerfile true }
            steps {
                sh "pwd && ls"
                sh "rm -rf intro_android_demo"
                sh "git clone https://github.com/codepath/intro_android_demo && cd intro_android_demo && whoami && ls"
                //sh "./gradlew tasks"
            }
        } 
        stage('Build using CMD') {
            agent {
                docker {
                    image 'temp:latest'
                    label 'templ'
                    args  '-v /tmp:/tmp'
                }
                stage ('Build using CMD 2') {
                    steps {
                        sh "ls"
                    }
                }
            }
        }
    }
}
