locals {
    required_tags = {
        project = var.project_name,
        environment = var.environment
    }
    tags = merge(var.resource_tags, local.required_tags)
}

locals {
    name_suffix = "${var.project_name}-${var.environment}"
}

# Susikuriam VPC (nežinau kaip viskas veikė 50-am tf faile..)
resource "aws_vpc" "main" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags                 = merge(local.tags, { Name = "vpc-${local.name_suffix}"})
}

# Sukuriam subnetą
resource "aws_subnet" "main" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.0.0/24"
    map_public_ip_on_launch = true
    availability_zone       = data.aws_availability_zones.available.names[0]
    tags                    = merge(local.tags, { Name = "subnet-${local.name_suffix}"})
}

# Sukuriam IGW
resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags   = merge(local.tags, { Name = "igw-${local.name_suffix}"})
}

# Sukuriam route table
resource "aws_route_table" "main" {
    vpc_id = aws_vpc.main.id
    routes = [
        {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.main.id
        }
    ]
    tags   = merge(local.tags, { Name = "rt-${local.name_suffix}"})
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
        form_port   = 80
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

    tags   = merge(local.tags, { Name = "sg-${local.name_suffix}"})

}

resource "aws_db_instance" "database" {
    allocated_storage   = 5
    engine              = "mysql"
    instance_class      = "db.t2.micro"
    username            = var.db_username
    password            = var.db_password
    vpc_security_group_ids = [aws_security_group.instance_sg.id]
    skip_final_snapshot = true
    tags = merge(local.tags, { Name = "db-${local.name_suffix}"})
}

resource "aws_instance" "app_server" {
    ami           = "ami-0d118c6e63bcb554e"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.main.id
    security_groups = [aws_security_group.instance_sg.name]
    tags = "${merge(local.tags, {Name="app-server-${local.name_suffix}"})}"
}

resource "aws_instance" "backend_server" {
    ami           = "ami-0d118c6e63bcb554e"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.main.id
    security_groups = [aws_security_group.instance_sg.name]
    tags = "${merge(local.tags, {Name="backend-server-${local.name_suffix}"})}"
}
