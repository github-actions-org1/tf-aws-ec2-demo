pipeline {
agent any
}

stages {
   // Check out from GIT, Snippet Generato from pipeline Syntax --> Checkout: Check out from version control 
    stage ("Check from GIT") {
        steps {
           git branch: 'main', credentialsId: 'ssh-private-repo', url: 'https://github.com/github-actions-org1/tf-aws-ec2-demo.git'
              }
       }
       // Terraform Init Stage
    stage ("Terraform init") {
        steps {
            // sh 'terraform -chdir="./v.14/test_env" init -upgrade'
             // terraform init -backend-config="bucket=kobai-s3-backend-terraform-state" -backend-config="key=stage-test-env/terraform.tfstate"
                 sh 'terraform init -migrate-state' 
              }
    }
    // Terraform fmt Stage
    stage ("Terraform fmt") {
        steps {
            sh 'terraform fmt'
        }
    }
    // Terraform Validate Stage
    stage ("Terraform validate") {
        steps {
            sh 'terraform validate'
        }
    }

    // Terraform Plan Stage
    stage ("Terraform plan") {
        steps {
              sh 'terraform plan'
           // sh 'terraform -chdir="./v.14/test_env" plan'
            
        }
    }

    //  Terraform Apply Stage
    stage ("Terraform apply") {
        steps {
             sh 'terraform --auto-approve'
            //   sh 'terraform -chdir="./v.14/test_env" apply --auto-approve'
           
        }
    }
   // Approvel stage 
   stage ("DEV approval Destroy") {
        steps {
           echo "Taking approval from DEV Manager for QA Deployment"
           timeout(time: 7, unit: 'DAYS') {
           input message: 'Do you want to Destroy the Infra', submitter: 'admin'
           }
        }
    }
   // Destroy stage
      stage ("Terraform Destroy") {
         steps {
            sh 'terraform  destroy --auto-approve'
        }
     }
}
