pipelineJob("Terraform Pipeline") {
    definition {
        cpsScm {
            scm {
                git('https://github.com/github-actions-org1/tf-aws-ec2-demo.git')
            }
            scriptPath('Jenkinsfile')
        }
    }
}
pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = 'us-east-2'
        AWS_ACCESS_KEY_I = "$AWS_ACCESS_KEY_ID"
        AWS_SECRET_ACCESS_KEY = "$AWS_SECRET_ACCESS_KEY"
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
        stage('Upload State to S3') {
            steps {
                script {
                    sh 'aws s3 cp terraform.tfstate s3://terraform-state-lab-demo-01'
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}