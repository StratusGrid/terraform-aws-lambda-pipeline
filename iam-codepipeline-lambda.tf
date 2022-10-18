### CODEPIPELINE LAMBDA IAM ROLE ###
resource "aws_iam_role" "lambda_codepipeline" {
  name = "${var.name}-codepipeline"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "lambda_codepipeline" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${var.artifact_store_bucket_name}",
      "arn:aws:s3:::${var.artifact_store_bucket_name}/*"
    ]
  }
  statement {
    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild"
    ]
    resources = [
      aws_codepipeline.lambda_codepipeline.arn
    ]
  }
  statement {
    actions = [
      "codedeploy:CreateDeployment",
      "codedeploy:GetApplication",
      "codedeploy:GetApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetDeploymentConfig",
      "codedeploy:RegisterApplicationRevision"
    ]
    resources = [
      aws_codepipeline.lambda_codepipeline.arn
    ]
  }
  statement {
    actions = ["codestar-connections:UseConnection"
    ]
    resources = [var.codestar_connection_arn
    ]
  }
}

resource "aws_iam_role_policy" "lambda_codepipeline" {
  name   = "${var.name}_codepipeline_policy"
  role   = aws_iam_role.lambda_codepipeline.id
  policy = data.aws_iam_policy_document.lambda_codepipeline.json
}
