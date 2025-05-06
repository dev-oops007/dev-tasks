terraform {
  backend "s3" {
    bucket = "dev-test-tf-state"
    key = "terraform/test/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt = true
  }
}