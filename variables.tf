#### Tag variables ####
variable "pipeline-name" {
  type    = string
  default = "aws-alexa-brookfield-ymca"
}

#### Terraform resource name variables ####
variable "lambda_function_name" {
  type    = string
  default = "aws-alexa-brookfield-ymca"
}

variable "lambda_role_name" {
  type    = string
  default = "aws-alexa-brookfield-ymca-role"
}

variable "alexa_skill_id" {
  type    = string
}

#### locals ####
locals {
  common_tags = {
    application = "Brookfield YMCA"
    environment = "sandbox"
    pipeline    = var.pipeline-name
  }
}