pipeline {
  agent any
 
tools {
jdk 'JDK8'
maven 'maven'
}

environment {
    dockerimagename = "humbertopeluso/jumiabackend"
    dockerImage = ""
  }


  stages {
    stage ('checkout') {
      steps {
           checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], 
           userRemoteConfigs: [[credentialsId: 'c0452f03-5f21-4f68-899e-a68a4733885b', url: 'https://github.com/HumbertoPeluso2/jumia_challenge']]])
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
            dockerImage = docker.build dockerimagename
          }
        }
      }
    }
     stage('Deploy Docker Image backend') {
       steps {
        script {
          docker.withRegistry('https://hub.docker.com', dockerhub-psswd)
          dockerImage.push("latest")
        }
            }
        } 
}
}
