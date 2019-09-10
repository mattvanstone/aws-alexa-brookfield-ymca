output "lambda-execution-role" {
  value = aws_iam_role.lambdarole.arn
}
output "lambda-arn" {
  value = "${aws_lambda_function.alexa_lambda.arn}"
}
