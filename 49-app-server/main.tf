terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>5.38"
        }
    }

    required_version = ">= 1.2.0"
}

provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "app_server" {
    ami = "ami-0d118c6e63bcb554e"
    instance_type = "t2.micro"

    tags = {
        Name = "AppServer instance"
    }
}

