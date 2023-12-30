pipeline {
    agent any
    stages {
        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                    sh 'terraform init'
                }
            }
        }
    }
    stages {
        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                    sh 'terraform plan -out=tfplan -lock=false'
                }
            }
        }
    }
    stages {
        stage('Terraform Apply') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                    sh 'terraform apply -auto-approve tfplan -lock=false'
                }
            }
        }
    }
}