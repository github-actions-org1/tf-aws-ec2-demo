pipeline {
    agent any
    stages {
        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                    sh 'terraform init'
                    sh 'terraform fmt'
                    sh 'terraform init -reconfigure'
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

        // Approvel stage 
        stage ("DEV approval Destroy") {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                    echo "Taking approval from DEV Manager for QA Deployment"
                    timeout(time: 7, unit: 'DAYS') {
                    input message: 'Do you want to Destroy the Infra', submitter: 'admin'
                    }
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