
module "fn-on-demand-scale-in-out" {
  source             = "./_modules/aws-lambda"
  function_name      = "on-demand-scale-in-out"
  function_handler   = "main-linux-amd64"
  runtime            = "go1.x"
  execution_role_arn = "arn:aws:iam::${local.account_id}:role/iamsr/lambda-function-role"
  source_file        = "../app/functions/on-demand-scale-in-out/bin/main-linux-amd64"
}



module "fn1" {
  source             = "./_modules/aws-lambda"
  function_name      = "fn1"
  function_handler   = "index.handler"
  runtime            = "nodejs14.x"
  execution_role_arn = "arn:aws:iam::${local.account_id}:role/iamsr/lambda-function-role"
  source_file        = "../app/functions/fn1/index.js"
}

module "fn2" {
  source             = "./_modules/aws-lambda"
  function_name      = "fn2"
  function_handler   = "index.handler"
  runtime            = "nodejs14.x"
  execution_role_arn = "arn:aws:iam::${local.account_id}:role/iamsr/lambda-function-role"
  source_file        = "../app/functions/fn2/index.js"
}


resource "aws_api_gateway_rest_api" "example" {
  name = "example"
  body = templatefile("./_templates/apigateway-openapi.tfpl", {
    account_id = local.account_id,
    region     = local.region,
    fn1_arn    = module.fn1.arn
  })

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
