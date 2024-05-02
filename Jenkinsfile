pipeline {
    agent any  
    environment {
        PATH = "/opt/apache-maven-3.9.6/bin:$PATH"
    }
    stages {
        stage('SCM') {
            steps {
                git branch: 'ravdy', url: 'https://github.com/abraham218/MayBilla-2024.git'
            }
        }
       stage('BUILD') {
            steps{
                echo "--------- DEPLOY STARTED ------------------"
                sh "mvn clean install -Dmaven.test.skip=true"
                echo "--------- DEPLOY  COMPLETED ---------------"
            }
       }
       stage('TEST'){
           steps{
               echo "--------- UNIT TEST STARTED   ---------------"
               sh 'mvn surefire-report:report'
            echo "--------- UNIT TEST Completed ---------------"
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
       stage("Quality Gate"){
           steps {
               script{
                   timeout(time: 1, unit: 'HOURS') { // Just in case something goes wrong, pipeline will be killed after a timeout
                     def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
                     if (qg.status != 'OK') {
                       error "Pipeline aborted due to quality gate failure: ${qg.status}"
                       }
                    }
               }
           }
           
        }
    }   
}
