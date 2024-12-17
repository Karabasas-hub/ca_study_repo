provider "aws" {
  region = "eu-central-1"
}

resource "aws_iam_openid_connect_provider" "github" {
    url = "https://token.actions.githubusercontent.com"

    client_id_list = ["sts.amazonaws.com"]

    thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]

    tags = {
        Name = "github-oidc-provider"
    }
}

# lambdai paleisti naudosime sukurtą github rolę
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:Karabasas-hub/ca_study_repo:*"
          }
        }
      },
      {
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "lambda-execution-role"
  }
}

# Policy kad executinti Lambdą
resource "aws_iam_role_policy_attachment" "lambda_execution_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.lambda_execution_role.name
}

# S3 kibiras lambda deploymento paketui
resource "aws_s3_bucket" "lambda_bucket" {
  bucket_prefix = "lambda-function-bucket-"
}

# deploymentui zippinam pytono (lambda) scriptą
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_code.py"
  output_path = "${path.module}/lambda_code.zip"
}

# sukeliam lambda kodą į kibirą
resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "lambda_code.zip"
  source = data.archive_file.lambda_zip.output_path
}

# apsirašom pačios lambdos sukūrimą
resource "aws_lambda_function" "my_lambda" {
  function_name = "github-actions-lambda"
  role          = aws_iam_role.lambda_execution_role.arn
  runtime       = "python3.10"
  handler       = "lambda_code.lambda_handler"

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_code.key

  tags = {
    Name = "github-actions-lambda"
  }
}

# outputas lambda arn
output "lambda_function_arn" {
  value = aws_lambda_function.my_lambda.arn
}
