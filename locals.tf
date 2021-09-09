  locals {
  common_tags = merge(var.input_tags, {
    "ModuleSourceRepo" = "github.com/StratusGrid/terraform-aws-lambda-pipeline"
    }
  )
  environment_map = var.environment_variables[*]
}
