
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



# module "fn1" {
#   source             = "./_modules/aws-lambda"
#   function_name      = "fn1"
#   function_handler   = "index.handler"
#   runtime            = "nodejs14.x"
#   execution_role_arn = "arn:aws:iam::${local.account_id}:role/iamsr/lambda-function-role"
#   source_file        = "../app/functions/fn1/index.js"
# }

# module "fn2" {
#   source             = "./_modules/aws-lambda"
#   function_name      = "fn2"
#   function_handler   = "index.handler"
#   runtime            = "nodejs14.x"
#   execution_role_arn = "arn:aws:iam::${local.account_id}:role/iamsr/lambda-function-role"
#   source_file        = "../app/functions/fn2/index.js"
# }


# resource "aws_lambda_permission" "this" {
#   statement_id  = "allow-apigateway-post-execution"
#   action        = "lambda:InvokeFunction"
#   function_name = module.fn1.function_name
#   principal     = "apigateway.amazonaws.com"

#   # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
#   source_arn = "arn:aws:execute-api:${local.region}:${local.account_id}:${aws_api_gateway_rest_api.this.id}/*/POST/users"
# }

# resource "aws_api_gateway_rest_api" "this" {
#   name = "example"
#   body = templatefile("./_templates/apigateway-openapi.tfpl", {
#     account_id = local.account_id,
#     region     = local.region,
#     fn1_arn    = module.fn1.arn
#   })

#   endpoint_configuration {
#     types = ["REGIONAL"]
#   }
# }

# resource "aws_api_gateway_deployment" "this" {
#   rest_api_id = aws_api_gateway_rest_api.this.id

#   triggers = {
#     redeployment = sha1(jsonencode(aws_api_gateway_rest_api.this.body))
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_api_gateway_stage" "this" {
#   deployment_id = aws_api_gateway_deployment.this.id
#   rest_api_id   = aws_api_gateway_rest_api.this.id
#   stage_name    = "dev"
# }
