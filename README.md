#Repository for Module for AWS Lambda CICD
## Commands to run for each environment
### DEV
```
terraform init -backend-config=./init-tfvars/dev.tfvars 
terraform apply -var-file ./apply-tfvars/dev.tfvars
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.55.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_codebuild_project.lambda_codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_project.lambda_codedeploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codedeploy_app.lambda_deployment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_app) | resource |
| [aws_codedeploy_deployment_group.lambda_deployment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_deployment_group) | resource |
| [aws_codepipeline.lambda_codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_iam_role.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda_codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda_codedeploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda_codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.lambda_codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.lambda_codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.AWSCodeDeployRoleForLambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.lambda_codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_approval_deploy_enabled"></a> [approval\_deploy\_enabled](#input\_approval\_deploy\_enabled) | Enable approval for deployment step | `bool` | `true` | no |
| <a name="input_artifact_store_bucket_name"></a> [artifact\_store\_bucket\_name](#input\_artifact\_store\_bucket\_name) | Name of the bucket that stores artifacts | `string` | n/a | yes |
| <a name="input_codestar_connection_arn"></a> [codestar\_connection\_arn](#input\_codestar\_connection\_arn) | n/a | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description of what your Lambda Function does. | `string` | n/a | yes |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | List of key values for lambda environment variables | `map(string)` | `null` | no |
| <a name="input_github_branch_name"></a> [github\_branch\_name](#input\_github\_branch\_name) | Name of the source github branch | `string` | n/a | yes |
| <a name="input_github_repo_name"></a> [github\_repo\_name](#input\_github\_repo\_name) | The name of the GitHub repository | `string` | n/a | yes |
| <a name="input_input_tags"></a> [input\_tags](#input\_input\_tags) | Map of tags to apply to resources | `map(string)` | <pre>{<br>  "Developer": "Stratusgrid",<br>  "Provisioner": "Terraform"<br>}</pre> | no |
| <a name="input_lambda_filename"></a> [lambda\_filename](#input\_lambda\_filename) | Unique name for your Lambda Function | `string` | n/a | yes |
| <a name="input_lambda_handler"></a> [lambda\_handler](#input\_lambda\_handler) | Function entrypoint in your code. | `string` | n/a | yes |
| <a name="input_lambda_memory_size"></a> [lambda\_memory\_size](#input\_lambda\_memory\_size) | The manifest lambdas configured memory size | `number` | n/a | yes |
| <a name="input_lambda_runtime"></a> [lambda\_runtime](#input\_lambda\_runtime) | Identifier of the function's runtime. | `string` | `"python3.8"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of all of the module's resources | `string` | n/a | yes |
| <a name="input_policy_configs_map"></a> [policy\_configs\_map](#input\_policy\_configs\_map) | Map of objects to add policies to the iam role | `map(object({ name = string, arn = string, enabled = bool }))` | <pre>{<br>  "policy_S3_full": {<br>    "arn": "arn:aws:iam::aws:policy/AmazonS3FullAccess",<br>    "enabled": true,<br>    "name": "s3Fullaccess"<br>  },<br>  "policy_lambda_execute": {<br>    "arn": "arn:aws:iam::aws:policy/AWSLambdaExecute",<br>    "enabled": true,<br>    "name": "lambdaExecute"<br>  },<br>  "policy_secrets_read": {<br>    "arn": "arn:aws:iam::aws:policy/SecretsManagerReadWrite",<br>    "enabled": true,<br>    "name": "secretmanageReadWrite"<br>  },<br>  "policy_sqs_full": {<br>    "arn": "arn:aws:iam::aws:policy/AmazonSQSFullAccess",<br>    "enabled": true,<br>    "name": "sqsFullAccess"<br>  },<br>  "policy_ssm_readonly": {<br>    "arn": "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",<br>    "enabled": true,<br>    "name": "ssmReaOnly"<br>  },<br>  "policy_xray_full": {<br>    "arn": "arn:aws:iam::aws:policy/AWSXrayFullAccess",<br>    "enabled": true,<br>    "name": "xrayFullAccess"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | n/a |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | n/a |
