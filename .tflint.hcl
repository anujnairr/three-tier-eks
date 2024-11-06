plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

plugin "aws" {
  enabled   = true
  region    = "us-west-2"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  version = "0.34.0"
}

