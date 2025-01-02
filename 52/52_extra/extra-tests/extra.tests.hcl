run "check_instance_name_suffix"{
    assert{
        condition     = aws_instance.main.tags["Name"] == "App-server-extra"
        error_message = "The name tag does not have the correct suffix"
    }
}

run "check_environment_tag" {
    assert{
        condition     = contains(keys(aws_instance.main.tags), "environment")
        error_message = "The instance does not have an environment tag"
    }
}

run "check_instance_type" {
    assert{
        condition     = aws_instance.main.instance_type == "t2.micro"
        error_message = "The instance type is not t2.micro"
    }
}