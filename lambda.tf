resource "aws_lambda_function" "this" {
  filename                       = var.lambda_filename
  description                    = var.description
  function_name                  = var.name
  handler                        = var.lambda_handler
  layers                         = []
  memory_size                    = var.lambda_memory_size
  reserved_concurrent_executions = -1 //?
  role                           = aws_iam_role.lambda.arn
  runtime                        = var.lambda_runtime
  timeout                        = 60

  dynamic "environment" {
    for_each  = local.environment_map
    content {
      variables = environment.value
    }
  }

  timeouts {}

  tracing_config {
    mode = "Active"
  }

  tags = merge(
    local.common_tags,
    {
    },
  )

  lifecycle { //todo: remove or add aditional things?
    ignore_changes = [
      filename,
      last_modified,
      source_code_hash
    ]
  }
}

### IAM ROLES, POLICIES AND ATTACHMENTS ###

resource "aws_iam_role" "lambda" {
  name        = var.name
  description = "Allows Lambda functions to call AWS services on your behalf."

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement":
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "AWS" : [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        ],
        "Service": "lambda.amazonaws.com"
      }
    }
}
EOF

  tags = merge(
    local.common_tags,
    {
    },
  )
}

locals {
    policies = {
    for param, policy in var.policy_configs_map : param => policy.arn if policy.enabled
  }
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role = aws_iam_role.lambda.name
  for_each   = local.policies
  policy_arn = each.value
}

resource "aws_cloudwatch_log_group" "lambda" {
  name = var.name
  tags = merge(local.common_tags, {})
}

//data "aws_iam_policy" "aws_lambda_execute" {
//  arn = "arn:aws:iam::aws:policy/AWSLambdaExecute"
//}
//
//data "aws_iam_policy" "amazon_ssm_read_only_access" {
//  arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
//}
//
//data "aws_iam_policy" "aws_xray_full_access" {
//  arn = "arn:aws:iam::aws:policy/AWSXrayFullAccess"
//}
//
//data "aws_iam_policy" "aws_secretmanager_readwrite" {
//  arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
//}
//
//data "aws_iam_policy" "lambda_s3_policy" {
//  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
//}
//
//data "aws_iam_policy" "lambda_sqs_policy" {
//  arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
//}
//
//resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
//  role       = aws_iam_role.lambda.name
//  policy_arn = data.aws_iam_policy.lambda_s3_policy.arn
//}
//
//resource "aws_iam_role_policy_attachment" "aws_secretmanager_readwrite" {
//  role       = aws_iam_role.lambda.name
//  policy_arn = data.aws_iam_policy.aws_secretmanager_readwrite.arn
//}
//
//resource "aws_iam_role_policy_attachment" "aws_lambda_execute" {
//  role       = aws_iam_role.lambda.name
//  policy_arn = data.aws_iam_policy.aws_lambda_execute.arn
//}
//
//resource "aws_iam_role_policy_attachment" "amazon_ssm_read_only_access" {
//  role       = aws_iam_role.lambda.name
//  policy_arn = data.aws_iam_policy.amazon_ssm_read_only_access.arn
//}
//
//resource "aws_iam_role_policy_attachment" "aws_xray_full_access" {
//  role       = aws_iam_role.lambda.name
//  policy_arn = data.aws_iam_policy.aws_xray_full_access.arn
//}
//
//resource "aws_iam_role_policy_attachment" "aws_sqs_excecution" {
//  role  = aws_iam_role.lambda.name
//  policy_arn = data.aws_iam_policy.lambda_sqs_policy.arn
//}
