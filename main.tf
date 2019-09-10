provider "aws" {
  version = "~> 2.9"
  region  = "us-east-1"
}

#### Backend Bucket ####
resource "aws_s3_bucket" "tf-state-bucket" {
  # Update backend.tf with new value
  bucket = "aws-alexa-brookfield-ymca-bucket"
  versioning {
    enabled = true
  }
  acl           = "private"
  force_destroy = true

  tags = local.common_tags
}

#### Backend Dynamodb Table ####
resource "aws_dynamodb_table" "tf-state-table" {
  # Update backend.tf with new value
  name         = "aws-alexa-brookfield-ymca"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 14

  tags = local.common_tags
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "source"
  output_path = "lambda.zip"
}

resource "aws_lambda_permission" "default" {
  statement_id       = "AllowExecutionFromAlexa"
  action             = "lambda:InvokeFunction"
  function_name      = "${aws_lambda_function.alexa_lambda.function_name}"
  principal          = "alexa-appkit.amazon.com"
  event_source_token = "${var.alexa_skill_id}"
}

resource "aws_lambda_function" "alexa_lambda" {
  filename         = "lambda.zip"
  function_name    = "aws-alexa-brookfield-ymca"
  role             = "${aws_iam_role.lambdarole.arn}"
  handler          = "lambda_function.lambda_handler"
  timeout          = 5
  memory_size      = 128
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "python2.7"

  tags = local.common_tags
}

resource "aws_resourcegroups_group" "aws-alexa-brookfield-ymca" {
  name = "rg-${var.pipeline-name}"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::AllSupported"
  ],
  "TagFilters": [
    {
      "Key": "pipeline",
      "Values": ["${var.pipeline-name}"]
    }
  ]
}
JSON
  }
}