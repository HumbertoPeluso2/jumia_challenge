pipeline {
  agent any
 
tools {
jdk 'JDK8'
maven 'maven'
}
  stages {
    stage ('checkout') {
      steps {
          git branch: 'main', url: 'https://github.com/HumbertoPeluso2/jumia_challenge'
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
