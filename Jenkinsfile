pipeline {
  agent any
  environment {
    TF_IN_AUTOMATION = 'true'
    AWS_SHARED_CREDENTIALS_FILE='/var/lib/jenkins/.aws/credentials'
  }

  stages {
    stage('Init TF') {
      steps {
        sh '''
          ls -al
          terraform init
        '''
      }
    }

    stage('Plan TF') {
      steps {
        sh '''
          terraform plan
        '''
      }
    }

    stage('Validate TF') {
      input {
        message "Do you want to apply this Plan?"
        ok "Apply Plan"
      }
      steps {
        echo 'Plan Accepted'
      }
    }

    stage('Apply TF') {
      steps {
        sh '''
          terraform apply -auto-approve
        '''
      }
    }

    stage('Validate Destroy') {
      input {
        message "Do you want to destroy Terraform Infra?"
        ok "Destroy"
      }
      steps {
        echo "Destroy Accepted"
      }
    }

    stage('Destroy TF') {
      steps {
        sh '''
          terraform destroy -auto-approve
        '''
      }
    }
  }
}