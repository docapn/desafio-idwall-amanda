terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
  access_key = "AKIA4LAQO5PHFZ4FGWR2"
  secret_key = "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"
}

resource "aws_vpc" "apn_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "apn_subnet" {
  vpc_id            = aws_vpc.apn_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
}


resource "aws_instance" "apn_ec2" {
    ami = "ami-024e6efaf93d85776"
    instance_type = "t2.micro"
}



resource "aws_security_group" "apn_sg" {
  name = "apn_sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
