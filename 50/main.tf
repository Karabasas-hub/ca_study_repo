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

resource "aws_db_instance" "database" {
    allocated_storage   = 5
    engine              = "mysql"
    instance_class      = "db.t2.micro"
    username            = var.db_username
    password            = var.db_password

    skip_final_snapshot = true
}

resource "aws_instance" "app_server" {
    ami           = "ami-0d118c6e63bcb554e"
    instance_type = "t2.micro"
    tags = "${merge(local.tags, {Name="app-server-${local.name_suffix}"})}"
}

resource "aws_instance" "backend_server" {
    ami           = "ami-0d118c6e63bcb554e"
    instance_type = "t2.micro"
    tags = "${merge(local.tags, {Name="backend-server-${local.name_suffix}"})}"
}
