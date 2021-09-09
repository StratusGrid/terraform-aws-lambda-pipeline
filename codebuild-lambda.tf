resource "aws_codebuild_project" "lambda_codebuild" {
  name          = "${var.name}-build"
  description   = "lambda function codebuild build project."
  build_timeout = "30"
  service_role  = aws_iam_role.lambda_codebuild.arn

  artifacts {
    type                = "CODEPIPELINE"
    artifact_identifier = "build"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    privileged_mode = true

    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = data.aws_region.current.name
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = <<BUILDSPEC
version: 0.2
phases:
  build:
    commands:
      - cd ./function
      - zip --recurse-paths ../lambda.zip *
artifacts:
  files:
    - 'lambda.zip'
  BUILDSPEC
  }

  tags = local.common_tags
}

resource "aws_codebuild_project" "lambda_codedeploy" {
  name          = "${var.name}-deploy"
  description   = "lambda function codebuild deploy project."
  build_timeout = "30"
  service_role  = aws_iam_role.lambda_codebuild.arn

  artifacts {
    type                = "CODEPIPELINE"
    artifact_identifier = "build"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    privileged_mode = true

    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = data.aws_region.current.name
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }
  }
//todo: Change this in a way that it uses codedeploy instead of codebuild
  source {
    type      = "CODEPIPELINE"
    buildspec = <<BUILDSPEC
version: 0.2
phases:
  build:
    commands:
      - aws lambda update-function-code --function-name ${aws_lambda_function.this.function_name} --zip-file fileb://$CODEBUILD_SRC_DIR/lambda.zip --publish
artifacts:
  files:
    - '**/*'
  BUILDSPEC
  }

  tags = local.common_tags
}
