terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~>5.38"
        }
    }

    required_version = ">= 1.2.0"
    backend "s3" {
        bucket         = "kibiras-test"
        key            = "terraform.tfstate"
        region         = "eu-central-1"
        encrypt        = true
        dynamodb_table = "lenta-test"
    }
}

# Susikuriam VPC (nežinau kaip viskas veikė 50-am tf faile..)
resource "aws_vpc" "main" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
}

# Sukuriam subnetą
resource "aws_subnet" "main" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.0.0/24"
    availability_zone       = "eu-central-1a"
    map_public_ip_on_launch = true
}

# Sukuriam IGW
resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
}

# Sukuriam route table
resource "aws_route_table" "main" {
    vpc_id = aws_vpc.main.id
}

resource "aws_route" "internet_access" {
    route_table_id         = aws_route_table.main.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.main.id
}

# Surišam route table su subnetu
resource "aws_route_table_association" "main" {
    subnet_id      = aws_subnet.main.id
    route_table_id = aws_route_table.main.id
}

# Sukuriam security grupę savo EC2 instance-ui
resource "aws_security_group" "instance_sg" {
    name        = "instance-sg-${local.name_suffix}"
    description = "Security group for app server and backend server"
    vpc_id      = aws_vpc.main.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp" 
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
# Ateičiai - jei reik ec2 instance'o - pasidarai vpc, pasidarai subnetą, pasidarai IGW, route table, route table association, kad 
# surištum route table ir subnetą, routą pasidarai, kad uždėtum igw and route table ir galiausiai security grupes su ingress
# taisyklėmis 80 ir 22 portui (http ir ssh) ir egress taisyklę, kad nesiunti traffico lauk, tik klausaisi ties tais dviem portais
resource "aws_instance" "app_server" {
    ami                    = "ami-0d118c6e63bcb554e"
    instance_type          = var.instance_type
    subnet_id              = aws_subnet.main.id
    vpc_security_group_ids = [aws_security_group.instance_sg.id]
    tags                   = {
        Name = "VM-${var.environment}"
    }
}

resource "aws_instance" "backend_server" {
    ami                    = "ami-0d118c6e63bcb554e"
    instance_type          = "t2.micro"
    subnet_id              = aws_subnet.main.id
    vpc_security_group_ids = [aws_security_group.instance_sg.id]
}

############################################################
# Dalis iš 51 paskaitos practice time
############################################################

resource "aws_eip" "ip" {
    instance = aws_instance.app_server.id
}

