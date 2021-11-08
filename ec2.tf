terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

#configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIARBEGBEKMAYSGGQ55"
  secret_key = "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"
}

resource "aws_instance" "web_ec2" {
  ami             = data.aws_ami.ami_amazon_linux.id
  instance_type   = var.taille_ec2
  key_name        = "devops-amandine"
  security_groups = [aws_security_group.amandine-sg-tls-http.name]

  tags = var.ec2_tag

  root_block_device {
    delete_on_termination = true
  }
}

resource "aws_eip" "lb" {
  #instance = aws_instance.web_ec2.id
  vpc = true

  tags = var.ec2_tag
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web_ec2.id
  allocation_id = aws_eip.lb.id
}

data "aws_ami" "ami_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}