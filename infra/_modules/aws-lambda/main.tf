data "archive_file" "this" {
  type        = "zip"
  source_file = var.source_file
  output_path = "bin/${var.function_name}.zip"
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 7
}

resource "aws_lambda_function" "this" {
  filename         = data.archive_file.this.output_path
  function_name    = var.function_name
  handler          = var.function_handler
  role             = var.execution_role_arn
  source_code_hash = filebase64sha256(data.archive_file.this.output_path)
  runtime          = var.runtime
  memory_size      = 1024
  timeout          = 30
}
