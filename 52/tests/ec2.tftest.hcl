run "check_app_server_tag" {
    assert {
        condition = aws_instance.app_server.tags.Name == "App-server-${var.environment}"
        error_message = "Invalid name tag"
    }
}