pipeline {
  agent any
 
tools {
jdk 'JDK8'
maven 'maven'
}

  stages {
    stage ('checkout') {
      steps {
           checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], 
           userRemoteConfigs: [[credentialsId: 'jumiagithub', url: 'https://github.com/HumbertoPeluso2/jumia_challenge']]])
      }
    }
    stage ('Build backend') {
      steps {
          dir('jumia_phone_validator/validator-backend') {
            sh 'mvn clean install'
         }
      
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          dir('jumia_phone_validator/validator-backend'){
            sh 'docker build -t humbertopeluso/jumiabackend:latest .'

          }
        }
      }
    }
     stage('Deploy Docker Image backend') {
       steps {
        script {
           withCredentials([[
            $class: 'com.dabsquared.gitlabjenkins.connection.GitLabApiTokenImpl',
            credentialsId: 'dockerhub-psswd',
              variable: 'dockerhubpwd'
              ]]){
                 sh 'docker login -u humbertopeluso -p ${dockerhubpwd}'
              }
          sh 'docker push humbertopeluso/jumiabackend:latest'
        }
            }
        } 
}
}
