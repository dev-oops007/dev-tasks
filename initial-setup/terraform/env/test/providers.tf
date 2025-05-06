terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

#If you don’t want to hardcode shared_credentials_file or profile, you can set environment variables
# export AWS_SHARED_CREDENTIALS_FILE=~/.aws/credentials
provider "aws" {
    region = "us-east-1"
    profile = "terraformBotUser"
    #shared_credentials_files = "~/vagrant_data/.aws/credentials"
}
#export AWS_PROFILE=terraformBotUser
