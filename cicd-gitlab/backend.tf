# S3 bucket for state file storage
terraform {
  backend "s3" {
    bucket  = "gitlab-statefile-shey-hub"
    key     = "git-lab-cicd-pipline.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
}