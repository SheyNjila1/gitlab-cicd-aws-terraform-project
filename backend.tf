# S3 bucket for state file storage
terraform {
  backend "s3" {
    bucket  = "shey-gitlab-cicd-bucket-final"
    key     = "git-lab-cicd-pipline.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
}