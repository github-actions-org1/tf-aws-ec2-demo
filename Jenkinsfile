pipeline {
    agent any
    stages {

        // Init stage 
        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                    sh 'terraform init'
                    sh 'terraform init -reconfigure'
                    sh 'terraform fmt'
                }
            }
        }

        // Plan stage 
        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                    sh 'terraform plan -out=tfplan -lock=false'
                }
            }
        }

        // Apply stage 
        stage('Terraform Apply') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                    sh 'terraform apply -auto-approve tfplan -lock=false'
                }
            }
        }

        // Approval stage 
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
        stage('Terraform Destroy') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                    sh 'terraform destroy -auto-approve tfplan -lock=false'
                }
            }
        }        
    }    
}