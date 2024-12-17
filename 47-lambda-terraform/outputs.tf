output "lambda_function_name" {
  description = "Name of created Lambda function"
  value       = aws_lambda_function.my_lambda.function_name
}