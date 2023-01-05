module "iamsr" {
  source = "./_modules/aws-iamsr"

  replacement_vars = {
    account_id = local.account_id
    region     = local.region
  }

  policies = {
    policy-cloudwatch-logs = "./_iamsr/policies/policy-cloudwatch-logs.tftpl",
    policy-lambda-invoke   = "./_iamsr/policies/policy-lambda-invoke.tftpl",
    policy-ecs             = "./_iamsr/policies/policy-ecs.tfpl"
  }

  roles = {
    lambda-function-role = {
      trust_role = "./_iamsr/assume_roles/trust-lambda.tftpl"
      policies_attachments = [
        "arn:aws:iam::${local.account_id}:policy/policy-cloudwatch-logs",
        "arn:aws:iam::${local.account_id}:policy/policy-ecs"
      ]
    },
    esc-task-execution-role = {
      trust_role = "./_iamsr/assume_roles/trust-ecs.tftpl"
      policies_attachments = [
        "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
      ]
    }
  }
}
