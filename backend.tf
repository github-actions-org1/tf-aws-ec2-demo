terraform {
  backend "s3" {
    bucket         = "s3-remote-backend-20231224202330732000000001"
    key            = "terra-backend/terraform.tfstate"
    encrypt        = true
    region         = "us-east-2"
    dynamodb_table = "dynamodb-state-locking"
  }
}