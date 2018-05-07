pipeline {
    agent { label 'dockerfile'}
    stages {
        stage('Build') {
            agent { docker 'jacekmarchwicki/android'}
            steps {
                echo 'I am in docker'
                sh "./gradlew test"
            }
        } 
    }
}
