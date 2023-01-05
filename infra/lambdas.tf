
module "fn-on-demand-scale-in-out" {
  source             = "./_modules/aws-lambda"
  function_name      = "on-demand-scale-in-out"
  function_handler   = "main-linux-amd64"
  runtime            = "go1.x"
  execution_role_arn = "arn:aws:iam::${local.account_id}:role/iamsr/lambda-function-role"
  source_file        = "../app/functions/on-demand-scale-in-out/bin/main-linux-amd64"
}

resource "aws_lambda_permission" "this" {
  statement_id  = "allow-eventbridge-execution"
  action        = "lambda:InvokeFunction"
  function_name = module.fn-on-demand-scale-in-out.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this.arn
}
