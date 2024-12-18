# VPC
resource "aws_vpc" "main" {
    cidr_block           = var.cidr_block
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name = "${var.environment}-vpc"
    }
}

# Public subnets
resource "aws_subnet" "public" {
    count                   = 3
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.${count.index}.0/24"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.environment}-subnet-${count.index +1}"
    }
}

# IGW
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.environment}-igw"
    }
}

# Route table for subnets
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.environment}-public-rt"
    }
}

# Route tables surišam su subnetais
resource "aws_route_table_association" "public_assoc" {
    count          = length(aws_subnet.public)
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

# Security group
resource "aws_security_group" "ssh_http" {
    vpc_id = aws_vpc.main.id

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

    egress = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.environment}-sg"
    }
}

#SSH key pair
resource "aws_key_pair" "key" {
    key_name = var.key_name
    public_key  file(var.public_key_path)
}

#EC2 vm'ai
resource "aws_instance" "vm" {
    count           = 3
    ami             = "ami-002738de72d8deab5" 
    instance_type   = var.machine_type
    key_name        = aws_key_pair.key.key_name
    subnet_id       = aws_subnet.public[count.index].id
    security_groups = [
        aws_security_group.ssh_http.name
    ]

    tags = {
        Name = "${var.environment}-vm-${count.index + 1}"
    }
}

output "public_ips" {
    value = aws_instance.vm[*].public_ip
    sensitive = true
    description = "Sukurtų vm'ų public IP"
}

