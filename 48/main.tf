
module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "4.0.2"

    name = "${var.environment}-vpc"
    cidr = var.cidr_block

    azs            = ["eu-central-1", "eu-central-1", "eu-central-1"]
    public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

    enable_dns_support   = true
    enable_dns_hostnames = true
}

# IGW
resource "aws_internet_gateway" "igw" {
    vpc_id = module.vpc.vpc_id

    tags = {
        Name = "${var.environment}-igw"
    }
}

# Route table for subnets
resource "aws_route_table" "public" {
    vpc_id = module.vpc.vpc_id

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
    count          = length(module.vpc.public_subnets)
    subnet_id      = module.vpc.public_subnets[count.index]
    route_table_id = aws_route_table.public.id
}

# Security group
resource "aws_security_group" "ssh_http" {
    vpc_id = module.vpc.vpc_id

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

    tags = {
        Name = "${var.environment}-sg"
    }
}

#SSH key pair
resource "aws_key_pair" "key" {
    key_name   = var.key_name
    public_key = file(var.public_key_path)
}

module "ec2_instances" {
    for_each = {
        "instance1" = module.vpc.public_subnets[0]
        "instance2" = module.vpc.public_subnets[1]
        "instance3" = module.vpc.public_subnets[2]
    }

    source                 = "./modules"
    depends_on             = [module.vpc]
    ec2_count              = 1
    ami                    = "ami-002738de72d8deab5" 
    instance_type          = var.machine_type
    key_name               = aws_key_pair.key.key_name
    subnet_id              = each.value
    security_group_ids     = [aws_security_group.ssh_http.id]
    environment            = var.environment
}


#EC2 vm'ai
#module "github_ec2_instance" {
#    source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance"
#    count                  = 3
#    ami                    = "ami-002738de72d8deab5" 
#    instance_type          = var.machine_type
#    key_name               = aws_key_pair.key.key_name
#    subnet_id              = module.vpc.public_subnets[count.index]
#    vpc_security_group_ids = [aws_security_group.ssh_http.id]
#
#    tags = {
#        Name = "${var.environment}-vm-${count.index + 1}"
#    }
#}

