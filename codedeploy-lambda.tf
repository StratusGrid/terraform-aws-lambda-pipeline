resource "aws_codedeploy_app" "lambda_deployment" {
  name             = var.name
  compute_platform = "Lambda"
}

resource "aws_codedeploy_deployment_group" "lambda_deployment" {
  app_name               = aws_codedeploy_app.lambda_deployment.name
  deployment_group_name  = var.name
  service_role_arn       = aws_iam_role.lambda_codedeploy.arn
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_type   = "BLUE_GREEN"
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }
}
 