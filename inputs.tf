variable "approval_deploy_enabled" {
  description = "Enable approval for deployment step"
  type        = bool
  default     = true
}

variable "artifact_store_bucket_name" {
  description = "Name of the bucket that stores artifacts"
  type        = string
}

variable "codestar_connection_arn" {
  description = "Github ARN Connection"
  type        = string
}

variable "description" {
  description = "Description of what your Lambda Function does."
  type        = string
}

variable "detect_changes" {
  description = "Controls if the codepipeline execution is started automatically when you make a new commit on the repository."
  type        = bool
  default     = true
}

variable "environment_variables" {
  description = "List of key values for lambda environment variables"
  type        = map(string)
  default     = null
}

variable "github_branch_name" {
  description = "Name of the source github branch"
  type        = string
}

variable "github_repo_name" {
  description = "The name of the GitHub repository"
  type        = string
}

variable "input_tags" {
  description = "Map of tags to apply to resources"
  type        = map(string)
  default = {
    Developer   = "Stratusgrid"
    Provisioner = "Terraform"
  }
}

variable "lambda_filename" {
  description = "Unique name for your Lambda Function"
  type        = string
}

variable "lambda_handler" {
  description = "Function entrypoint in your code."
  type        = string
}

variable "layers" {
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function."
  type        = list(string)
  default     = []
}

variable "lambda_memory_size" {
  description = "The manifest lambdas configured memory size"
  type        = number
}

variable "lambda_runtime" {
  description = "Identifier of the function's runtime."
  type        = string
  default     = "python3.8"
}

variable "name" {
  description = "Name of all of the module's resources"
  type        = string
}

variable "policy_configs_map" {
  description = "Map of objects to add policies to the iam role"
  type        = map(object({ name = string, arn = string, enabled = bool }))
  default = {
    "policy_lambda_execute" = {
      "name"    = "lambdaExecute"
      "arn"     = "arn:aws:iam::aws:policy/AWSLambdaExecute"
      "enabled" = true
    }
    "policy_S3_full" = {
      "name"    = "s3Fullaccess"
      "arn"     = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
      "enabled" = true
    }
    "policy_sqs_full" = {
      "name"    = "sqsFullAccess"
      "arn"     = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
      "enabled" = true
    }
    "policy_xray_full" = {
      "name"    = "xrayFullAccess"
      "arn"     = "arn:aws:iam::aws:policy/AWSXrayFullAccess"
      "enabled" = true
    }
    "policy_ssm_readonly" = {
      "name"    = "ssmReaOnly"
      "arn"     = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
      "enabled" = true
    }
    policy_secrets_read = {
      "name"    = "secretmanageReadWrite"
      "arn"     = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
      "enabled" = true
    }
  }
}

#variable "source_repo" {
#  description = "The source repository for the terraform"
#  type        = string
#}
#
