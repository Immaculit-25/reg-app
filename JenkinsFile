pipeline{
    agent any
    tools{
        maven 'maven-3.9'
    }
    stages{
        stage("git clone"){
            steps{
                sh "cloning the code from the gitrepo"
                git branch: 'main', url: 'https://github.com/Immaculit-25/reg-app.git'
            }
        }
        stage("buildjar"){
            steps{
                sh "testing and build with maven"
                sh "mvn package"
            }
        }
        stage("buildImage"){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', passwordVariable: 'PASS', usernameVariable: 'USER')])
                {
                    sh "docker build -t imaculit/new-reg-app:v1 ."
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh "docker push imaculit/new-reg-app:v1"
                }

            }
        }
        stage("deploy"){
            steps{
                sh "docker run -d --name appv1 -p 9000:8080 imaculit/new-reg-app:v1 "
            }
        }
    }
}
