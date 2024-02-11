resource "aws_iam_policy" "ecr_push_policy" {
  name        = "ECRPushAccessForSlackerNewsMarketplace"
  description = "Policy that allows pushing images to ECR repositories"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:PutImage"
      ],
      "Resource": [
        "arn:aws:ecr:us-east-1:709825985650:repository/slackernews/slackernews",
        "arn:aws:ecr:us-east-1:709825985650:repository/slackernews/slackernews-chart",
        "arn:aws:ecr:us-east-1:709825985650:repository/slackernews/slackernews-nginx"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_user" "ecr_push_user" {
  name = "ecr-slackernews-marketplace-push-user"
}

resource "aws_iam_user_policy_attachment" "attach_ecr_push_policy" {
  user       = aws_iam_user.ecr_push_user.name
  policy_arn = aws_iam_policy.ecr_push_policy.arn
}
