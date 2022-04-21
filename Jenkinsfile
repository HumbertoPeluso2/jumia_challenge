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
            dockerImage = docker.build dockerimagename
          }
        }
      }
    }
     stage('Deploy Docker Image backend') {
       steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-psswd'){
          dockerImage.push("latest")
          }
        }
            }
        }
      stage('Deploying App to Kubernetes') {
      steps {
        script {
          withCredentials([$class:'AmazonWebServicesCredentialsBinding',credentialsId: 'aws-credentials']) {
            dir('jumia/backend'){
            kubernetesDeploy(configs: 'deployment.yml', kubeconfigId: 'kubeconfig')
          }
          }  
          
        }
      }
    } 
}
}
