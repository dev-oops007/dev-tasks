provider "aws" {
    region = "us-east-1"
}

#Creating VPC for initial Devops workstation
#vpc
resource "aws_vpc" "main" {
  cidr_block =
  enable_dns_support = 
  enable_dns_hostnames = 

}
