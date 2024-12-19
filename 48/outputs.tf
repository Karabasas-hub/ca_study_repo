output "vpc_id" {
    value = module.vpc.vpc_id
    description = "VPC ID"
}

output "subnet_ids" {
    value = module.vpc.public_subnets
    description = "Public subnet IDs"
}