pipeline {
    agent {
        node {
            label 'maven'
        }
    }
    environment {
        PATH = "/opt/apache-maven-3.9.6/bin:$PATH"
    }
    stages {
        stage('SCM') {
            steps {
                git branch: 'ravdy', url: 'https://github.com/abraham218/billa-2024.git'
            }
        }
        stage('BUILD') {
            steps{
                sh "mvn clean deploy"
            }
       }
       stage('SonarQube analysis') {
        environment {
            scannerHome = tool 'sonar-scanner';
        }
        steps{
            withSonarQubeEnv('sonarqube-server'){
                sh "${scannerHome}/bin/sonar-scanner"
               }
           }
       }
    }   
}