# Policy for GetAuthorizationToken on all resources
resource "aws_iam_policy" "ecr_token_policy" {
  name        = "ECRTokenAccess"
  description = "Allow GetAuthorizationToken on all ECR resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action    = [
          "ecr:GetAuthorizationToken"
        ]
        Resource = "*"
      },
    ]
  })
}

# Policy for specific actions on designated repositories
resource "aws_iam_policy" "ecr_repo_policy" {
  name        = "ECRRepoAccessSlackerNewsMarketplace"
  description = "Allow actions on specific ECR repositories for the SlackerNews Marketplace listing"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = [
          "ecr:ListImages",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
        Resource = [
          "arn:aws:ecr:us-east-1:709825985650:repository/slackernews/slackernews",
          "arn:aws:ecr:us-east-1:709825985650:repository/slackernews/chart/slackernews",
          "arn:aws:ecr:us-east-1:709825985650:repository/slackernews/byol/slackernews",
          "arn:aws:ecr:us-east-1:709825985650:repository/slackernews/byol/chart/slackernews",
          "arn:aws:ecr:us-east-1:709825985650:repository/slackernews/slackernews-nginx"
        ]
      },
    ]
  })
}

resource "aws_iam_policy" "marketplace_changeset_policy" {
  name        = "MarketplaceManagementSlackerNews"
  description = "Allow changeset management actions on SlackerNews Marketplace listing"

  # todo - this is kinda permissive, see if there's a way to restrict to specific ContainerProduct ARNs
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = [
          "aws-marketplace:ListChangeSets",
          "aws-marketplace:DescribeEntity",
          "aws-marketplace:StartChangeSet",
          "aws-marketplace:ListEntities",
          "aws-marketplace:DescribeChangeSet",
        ]
        Resource = [
          "*"
        ]
      },
    ]
  })
}

# Attach the policies to the IAM user
resource "aws_iam_user_policy_attachment" "attach_ecr_token_policy" {
  user       = aws_iam_user.ecr_push_user.name
  policy_arn = aws_iam_policy.ecr_token_policy.arn
}

resource "aws_iam_user_policy_attachment" "attach_ecr_repo_policy" {
  user       = aws_iam_user.ecr_push_user.name
  policy_arn = aws_iam_policy.ecr_repo_policy.arn
}

resource "aws_iam_user_policy_attachment" "attach_marketplace_changeset_policy" {
  user       = aws_iam_user.ecr_push_user.name
  policy_arn = aws_iam_policy.marketplace_changeset_policy.arn
}

resource "aws_iam_user" "ecr_push_user" {
  name = "ecr-slackernews-marketplace-push-user"
}
