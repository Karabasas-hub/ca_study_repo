output "vpc_id" {
    value = aws_vpc.main.id
    description = "VPC ID"
}

output "subnet_ids" {
    value = aws_subnet.public[*].id
    description = "Public subnet IDs"
}