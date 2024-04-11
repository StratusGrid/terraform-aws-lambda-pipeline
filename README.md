<!-- BEGIN_TF_DOCS -->
<p align="center">
  <img src="https://github.com/StratusGrid/terraform-readme-template/blob/main/header/stratusgrid-logo-smaller.jpg?raw=true" />
  <p align="center">
    <a href="https://stratusgrid.com/book-a-consultation">Contact Us</a> |
    <a href="https://stratusgrid.com/cloud-cost-optimization-dashboard">Stratusphere FinOps</a> |
    <a href="https://stratusgrid.com">StratusGrid Home</a> |
    <a href="https://stratusgrid.com/blog">Blog</a>
  </p>
</p>

# terraform-aws-lambda-pipeline
GitHub: [StratusGrid/terraform-aws-lambda-pipeline](https://github.com/StratusGrid/terraform-aws-lambda-pipeline)
## Example
```hcl
module "terraform-aws-lambda-pipeline" {
  source  = "stratusgrid/terraform-aws-lambda-pipeline"
}
```
## StratusGrid Standards we assume
- All resource names and name tags shall use `_` and not `-`s
- The old naming standard for common files such as inputs, outputs, providers, etc was to prefix them with a `-`, this is no longer true as it's not POSIX compliant. Our pre-commit hooks will fail with this old standard.
- StratusGrid generally follows the TerraForm standards outlined [here](https://www.terraform-best-practices.com/naming)
## Repo Knowledge
Repository for Module for AWS Lambda CICD
## Documentation
This repo is self documenting via Terraform Docs, please see the note at the bottom.
### `LICENSE`
This is the standard Apache 2.0 License as defined [here](https://stratusgrid.atlassian.net/wiki/spaces/TK/pages/2121728017/StratusGrid+Terraform+Module+Requirements).
### `outputs.tf`
The StratusGrid standard for Terraform Outputs.
### `README.md`
It's this file! I'm always updated via TF Docs!
### `tags.tf`
The StratusGrid standard for provider/module level tagging. This file contains logic to always merge the repo URL.
### `variables.tf`
All variables related to this repo for all facets.
One day this should be broken up into each file, maybe maybe not.
### `versions.tf`
This file contains the required providers and their versions. Providers need to be specified otherwise provider overrides can not be done.
## Documentation of Misc Config Files
This section is supposed to outline what the misc configuration files do and what is there purpose
### `.config/.terraform-docs.yml`
This file auto generates your `README.md` file.
### `.github/workflows/pre-commit.yml`
This file contains the instructions for Github workflows, in specific this file run pre-commit and will allow the PR to pass or fail. This is a safety check and extras for if pre-commit isn't run locally.
### `examples/*`
The files in here are used by `.config/terraform-docs.yml` for generating the `README.md`. All files must end in `.tfnot` so Terraform validate doesn't trip on them since they're purely example files.
### `.gitignore`
This is your gitignore, and contains a slew of default standards.
---
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9 |
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
| [aws_iam_role_policy_attachment.awscodedeployroleforlambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_approval_deploy_enabled"></a> [approval\_deploy\_enabled](#input\_approval\_deploy\_enabled) | Enable approval for deployment step | `bool` | `true` | no |
| <a name="input_artifact_store_bucket_name"></a> [artifact\_store\_bucket\_name](#input\_artifact\_store\_bucket\_name) | Name of the bucket that stores artifacts | `string` | n/a | yes |
| <a name="input_codestar_connection_arn"></a> [codestar\_connection\_arn](#input\_codestar\_connection\_arn) | Github ARN Connection | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description of what your Lambda Function does. | `string` | n/a | yes |
| <a name="input_detect_changes"></a> [detect\_changes](#input\_detect\_changes) | Controls if the codepipeline execution is started automatically when you make a new commit on the repository. | `bool` | `true` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | List of key values for lambda environment variables | `map(string)` | `null` | no |
| <a name="input_github_branch_name"></a> [github\_branch\_name](#input\_github\_branch\_name) | Name of the source github branch | `string` | n/a | yes |
| <a name="input_github_repo_name"></a> [github\_repo\_name](#input\_github\_repo\_name) | The name of the GitHub repository | `string` | n/a | yes |
| <a name="input_input_tags"></a> [input\_tags](#input\_input\_tags) | Map of tags to apply to resources | `map(string)` | <pre>{<br>  "Developer": "Stratusgrid",<br>  "Provisioner": "Terraform"<br>}</pre> | no |
| <a name="input_lambda_filename"></a> [lambda\_filename](#input\_lambda\_filename) | Unique name for your Lambda Function | `string` | n/a | yes |
| <a name="input_lambda_handler"></a> [lambda\_handler](#input\_lambda\_handler) | Function entrypoint in your code. | `string` | n/a | yes |
| <a name="input_lambda_memory_size"></a> [lambda\_memory\_size](#input\_lambda\_memory\_size) | The manifest lambdas configured memory size | `number` | n/a | yes |
| <a name="input_lambda_runtime"></a> [lambda\_runtime](#input\_lambda\_runtime) | Identifier of the function's runtime. | `string` | `"python3.8"` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function. | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of all of the module's resources | `string` | n/a | yes |
| <a name="input_policy_configs_map"></a> [policy\_configs\_map](#input\_policy\_configs\_map) | Map of objects to add policies to the iam role | `map(object({ name = string, arn = string, enabled = bool }))` | <pre>{<br>  "policy_S3_full": {<br>    "arn": "arn:aws:iam::aws:policy/AmazonS3FullAccess",<br>    "enabled": true,<br>    "name": "s3Fullaccess"<br>  },<br>  "policy_lambda_execute": {<br>    "arn": "arn:aws:iam::aws:policy/AWSLambdaExecute",<br>    "enabled": true,<br>    "name": "lambdaExecute"<br>  },<br>  "policy_secrets_read": {<br>    "arn": "arn:aws:iam::aws:policy/SecretsManagerReadWrite",<br>    "enabled": true,<br>    "name": "secretmanageReadWrite"<br>  },<br>  "policy_sqs_full": {<br>    "arn": "arn:aws:iam::aws:policy/AmazonSQSFullAccess",<br>    "enabled": true,<br>    "name": "sqsFullAccess"<br>  },<br>  "policy_ssm_readonly": {<br>    "arn": "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",<br>    "enabled": true,<br>    "name": "ssmReaOnly"<br>  },<br>  "policy_xray_full": {<br>    "arn": "arn:aws:iam::aws:policy/AWSXrayFullAccess",<br>    "enabled": true,<br>    "name": "xrayFullAccess"<br>  }<br>}</pre> | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | lambda ARN |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | lambda name |
---
Note, manual changes to the README will be overwritten when the documentation is updated. To update the documentation, run `terraform-docs -c .config/.terraform-docs.yml`
<!-- END_TF_DOCS -->