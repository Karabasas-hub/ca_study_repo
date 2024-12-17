provider "aws" {
  region = "eu-central-1" #nusakomas regionas, kur bus sukurtas resursas
}

# Sukuriamas GitHub OIDC provideris
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]

  tags = {
    Name = "github-oidc-provider"
  }
}

# IAM rolė, kurią galės užimti github actionsai
resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-role"

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
      }
    ]
  })

  tags = {
    Name = "github-actions-role"
  }
}

# Policy attatchmento pavyzdys IAM rolei
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}