pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:light'
            args '--entrypoint="" -u root'
        } 
    }
    // environment {
    //     AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
    //     AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    // }
    parameters {
        choice(
            choices: ['plan', 'apply', 'show', 'preview-destroy', 'destroy'],
            description: 'Terraform action to apply',
            name: 'action')
        // choice(
        //     choices: ['dev', 'test', 'prod'],
        //     description: 'deployment environment',
        //     name: 'ENVIRONMENT')
        // string(defaultValue: "fcz", description: 'application system identifier', name: 'ASI')
    }
    stages {
        stage('init') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                    sh 'terraform init -no-color'
                }
            }
        }
        stage('validate') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {
                    sh 'terraform validate -no-color'
                }    
            }
        }
        stage('plan') {
            when {
                expression { params.action == 'plan' || params.action == 'apply' }
            }
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {              
                    sh 'terraform plan -no-color -input=false -out=tfplan'
                }    
            }
        }
        stage('approval') {
            when {
                expression { params.action == 'apply'}
            }
            steps {
                sh 'terraform show -no-color tfplan > tfplan.txt'
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }
        stage('apply') {
            when {
                expression { params.action == 'apply' }
            }
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {              
                    sh 'terraform apply -no-color -input=false tfplan'
                }    
            }
        }
        stage('show') {
            when {
                expression { params.action == 'show' }
            }
            steps {
                sh 'terraform show -no-color'
            }
        }
        stage('preview-destroy') {
            when {
                expression { params.action == 'preview-destroy' || params.action == 'destroy'}
            }
            steps {
                sh 'terraform plan -no-color -destroy -out=tfplan'
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('destroy') {
            when {
                expression { params.action == 'destroy' }
            }
            steps {
                withAWS(credentials: 'aws-credentials', region: 'us-east-2') {                             
                    script {
                        def plan = readFile 'tfplan.txt'
                        input message: "Delete the stack?",
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                    }
                    sh 'terraform destroy -no-color -force'
                }    
            }
        }
    }
}