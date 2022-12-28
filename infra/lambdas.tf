
module "fn-on-demand-scale-in-out" {
  source             = "./_modules/aws-lambda"
  function_name      = "on-demand-scale-in-out"
  function_handler   = "main-linux-amd64"
  execution_role_arn = "arn:aws:iam::${local.account_id}:role/iamsr/lambda-function-role"
  source_file        = "../app/functions/on-demand-scale-in-out/bin/main-linux-amd64"
}

