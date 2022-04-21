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
           userRemoteConfigs: [[credentialsId: 'c0452f03-5f21-4f68-899e-a68a4733885b', url: 'https://github.com/HumbertoPeluso2/jumia_challenge']]])
      }
    }
    stage ('Build') {
      steps {
          dir('jumia_phone_validator/validator-backend') {
    // some block
            sh 'mvn clean install'
         }
      
      }
    }
}
}
