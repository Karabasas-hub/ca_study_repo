terraform {
    backend "s3" {
        bucket = "my-terraform-state-bucket"
        key = "state-files/project/terraform.tfstate"
        region = var.aws_region
        dynamodb_table = "terraform-lock-table"
    }
}