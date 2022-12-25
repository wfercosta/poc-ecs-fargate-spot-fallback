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
