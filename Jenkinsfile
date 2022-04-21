pipeline {
  agent any
 
tools {
jdk 'JDK8'
maven 'maven'
}
  stages {
    stage ('checkout') {
      steps {
          git branch: 'main', url: 'https://github.com/Jumia/DevOps-Challenge/tree/main/jumia_phone_validator'
      }
    }
    stage ('Build') {
      steps {
          dir('/validator-backend') {
    // some block
            sh 'mvn clean install'
         }
      
      }
    }
}
}
