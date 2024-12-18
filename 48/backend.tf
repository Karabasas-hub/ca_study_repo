terraform {
    backend "s3" {
        bucket = "my-terraform-state-bucket"
        key = "state-files/project/terraform.tfstate"
        region = "eu-central-1"
        dynamodb_table = "terraform-lock-table"
    }
}