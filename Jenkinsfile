 pipeline {
        agent any
        tools {
            maven 'maven-3.9'
        }
        stages{
            stage('git clone'){
                steps{
                    sh "echo cloning the code from github repo"
                    git branch: 'main', credentialsId: 'github-cred', url: 'https://github.com/Immaculit-25/reg-app.git'
                }
            }
            stage('unit-test'){
                steps {
                    sh "echo running a unit test"
                    sh "mvn test"
                }
            }
            stage('build-art'){
                steps {
                    sh "mvn package"
                }
            }
            stage('buildImage'){
                steps {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', passwordVariable: 'PASSWD', usernameVariable: 'USER')]) 
                    {
                     sh "docker build -t imaculit/new-reg-app:v1 ."
                     sh "echo $PASSWD | docker login -u $USER --password-stdin"
                     sh "docker push imaculit/new-reg-app:v1"
                    }
                }
            }
            stage('deploy'){
                steps {
                    sh "echo deploying into prod envt"
                    sh "docker run -d --name appv1 -p 9000:8080 imaculit/new-reg-app:v1"
                }
            }
        }
   }
