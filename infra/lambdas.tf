module "fn-on-demand-scale-in" {
  source             = "./_modules/aws-lambda"
  function_name      = "on-demand-scale-in"
  function_handler   = "main-linux-amd64"
  execution_role_arn = "arn:aws:iam::${local.account_id}:role/iamsr/lambda-function"
  source_file        = "../app/functions/on-demand-scale-in"
}

module "fn-on-demand-scale-out" {
  source             = "./_modules/aws-lambda"
  function_name      = "on-demand-scale-out"
  function_handler   = "main-linux-amd64"
  execution_role_arn = "arn:aws:iam::${local.account_id}:role/iamsr/lambda-function"
  source_file        = "../app/functions/on-demand-scale-out"
}
