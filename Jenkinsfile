pipeline {
    agent any
    stages {
        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                    sh 'terraform init'
                    sh 'terraform fmt'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                    sh 'terraform plan -out=tfplan -lock=false'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                    sh 'terraform apply -auto-approve tfplan -lock=false'
                }
            }
        }
    }    
}