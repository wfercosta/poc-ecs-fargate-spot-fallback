module "iamsr" {
  source = "./_modules/aws-iamsr"

  replacement_vars = {
    account_id = local.account_id
    region     = local.region
  }

  policies = {
    policy-cloudwatch-logs = "./_iamsr/policies/policy-cloudwatch-logs.tftpl"
  }

  roles = {
    lambda-function = {
      trust_role = "./_iamsr/assume_roles/trust-lambda.tftpl"
      policies_attachments = [
        "arn:aws:iam::${local.account_id}:policy/policy-cloudwatch-logs",
      ]
    }
  }
}


# module "fn-on-demand-scale-in" {
#   source             = "./_modules/aws-lambda"
#   function_name      = "on-demand-scale-in"
#   function_handler   = "main-linux-amd64"
#   execution_role_arn = "arn:aws:iam::${local.account_id}:role/iamsr/lambda-function"
#   source_file        = "../app/functions/on-demand-scale-in"
# }

# module "fn-on-demand-scale-out" {
#   source             = "./_modules/aws-lambda"
#   function_name      = "on-demand-scale-out"
#   function_handler   = "main-linux-amd64"
#   execution_role_arn = "arn:aws:iam::${local.account_id}:role/iamsr/lambda-function"
#   source_file        = "../app/functions/on-demand-scale-out"
# }
