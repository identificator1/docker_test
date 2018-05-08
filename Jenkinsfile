pipeline {
    agent { label 'docker'}
    stages {
        stage('Pretest') {
            steps {
                echo 'Local hostname is'
                sh "hostname"
            }
        }
        stage('Build using plugin') {
            agent { dockerfile true }
            steps {
                sh "pwd && ls"
                sh "rm -rf intro_android_demo"
                sh "git clone https://github.com/codepath/intro_android_demo && cd intro_android_demo"
                //sh "./gradlew tasks"
            }
        } 
        stage('Build using CMD') {
            steps {
                docker.image('ruby:2.3.1').inside {
                    sh "gem install bundler --no-rdoc --no-ri"
                    sh "bundle install"
                }
            } 
        }
        stage('Cleanup') {
            steps {
                step([$class: 'WsCleanup'])
            }
        }
    }
}
