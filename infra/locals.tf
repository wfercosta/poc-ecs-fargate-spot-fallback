locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = "us-east-1"
}
