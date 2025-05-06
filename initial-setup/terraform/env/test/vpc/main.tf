module "vpc" {
  source = "../../modules/vpc"  # Adjust path if needed

  vpc_name           = "test-vpc"
  vpc_cidr           = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = [
    "10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24",
    "10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"
  ]
  devops_subnets     = ["10.0.30.0/24", "10.0.31.0/24"]
  azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
  enable_nat_gateway = false  # NAT instance is used
  nat_ami_id         = "ami-0c55b159cbfafe1f0"  # Replace with your region's NAT instance AMI
  nat_instance_type  = "t3.micro"

  tags = {
    Environment = "Test"
    Project     = "DevSecOps-Platform"
  }
}

