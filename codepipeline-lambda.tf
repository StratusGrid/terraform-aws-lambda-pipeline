resource "aws_codepipeline" "lambda_codepipeline" {
  name     = var.name
  role_arn = aws_iam_role.lambda_codepipeline.arn

  artifact_store {
    location = var.artifact_store_bucket_name//aws_s3_bucket.test_resources_bucket.id
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]


      configuration = {
        ConnectionArn    = var.codestar_connection_arn//data.aws_codestarconnections_connection.github.arn
        FullRepositoryId = var.github_repo_name
        BranchName       = var.github_branch_name
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.lambda_codebuild.name
      }
    }
  }
  stage {
    name = "Deploy_${var.name}" //?

    dynamic "action" {
      for_each = var.approval_deploy_enabled == true ? ["true"] : []
      content {
        category         = "Approval"
        configuration    = {}
        input_artifacts  = []
        name             = "Deploy_Approval"
        output_artifacts = []
        owner            = "AWS"
        provider         = "Manual"
        run_order        = 1
        version          = "1"
      }
    }
    action {
      name            = "Deploy_${var.name}" //?
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["build_output"]
      version         = "1"
      run_order       = 2
      configuration = {
        ProjectName = aws_codebuild_project.lambda_codedeploy.name
      }
    }
  }
}
