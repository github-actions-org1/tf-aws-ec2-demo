pipeline {
    agent any
    tools {
        terraform "terraform"
    }
    stages {
        stage("Destroy") {
            environment {
                TFSTATE = sh (returnStdout: true, script: 
                """
                aws s3api list-buckets --query 'Buckets[].Name' | grep -wo "\\w*tf-remote-backend-state-lab20231114133906936800000001\\w*"
                """
                ).trim()
            }
            steps {
                script {
                    sh """
                    cd terraform
                    terraform init -no-color -backend-config="key=${UNIQUE_ANIMAL_IDENTIFIER}.tfstate" -backend-config="bucket=${TFSTATE}"
                    terraform destroy --auto-approve -no-color -var ARTIFACT=""
                    """
                }
            }
        }
    }
    post {
        cleanup {
            deleteDir()
        }
    }
}