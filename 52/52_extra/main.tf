terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>5.38"
        }
    }
    required_version = ">=1.2.0"

    # backend "s3" {
    #     bucket         = "extra-kibiras"
    #     key            = "terraform.tfstate"
    #     region         = "eu-central-1"
    #     encrypt        = true
    #     dynamodb_table = "extra-lenta"
    # }
}

resource "aws_vpc" "main" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
}

resource "aws_subnet" "main" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "eu-central-1a"
    map_public_ip_on_launch = true
}

resource "aws_instance" "main" {
    ami           = "ami-0d118c6e63bcb554e"
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.main.id
    tags = {
        Name = "App-server-extra"
    }
}

