resource "aws_instance" "virtual_machine" {
    count                  = 3
    ami                    = "ami-0fb820135757d28fd" 
    instance_type          = var.machine_type
    key_name               = aws_key_pair.key.key_name
    subnet_id              = aws_subnet.public[count.index].id
    vpc_security_group_ids = [aws_security_group.ssh_http.id]

    tags = {
        Name = "${var.environment}-vm-${count.index + 1}"
    }
}
