pipeline {
    agent { docker 'jacekmarchwicki/android'}
    stages {
        stage('Build') {
            steps {
                echo 'I am in docker'
                sh "./gradlew build ."
            }
        } 
    }
}
