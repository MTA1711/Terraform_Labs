terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  #define the remote backend
  backend "s3" {
    bucket = "terraform-backend-achille"
    key    = "./terraform.tfstate"
    region = "us-east-1"
  }
}

#configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

module "security_group" {
  source = "./modules/security_group"
  sg_tag = {
    Name = "sg-achille"
  }
}

module "ec2" {
  source  = "./modules/ec2"
  sg_name = module.security_group.sg_name
  ec2_tag = {
    Name = "ec2-achille"
  }
  instance_type = "t2.micro"
  key_name      = "devops-ajc"
  key_path      = "./devops-ajc.pem"
}

module "ip" {
  source = "./modules/ip"
  lb_tag = {
    Name = "lb-achille"
  }
}

module "ebs" {
  source = "./modules/ebs"
  ebs_tag = {
    Name = "ebs-achille"
  }
  zone = "us-east-1a"
  size = 10
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = module.ec2.id
  allocation_id = module.ip.id
}
