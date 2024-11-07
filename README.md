![GitHub top language](https://img.shields.io/github/languages/top/anujnairr/three-tier-eks?color=purple)
![GitHub forks](https://img.shields.io/github/forks/anujnairr/three-tier-eks?style=social)
![GitHub Repo stars](https://img.shields.io/github/stars/anujnairr/three-tier-eks?style=social)

# Three-tier EKS

This deploys three APIs, DB with AWS EKS.  

## Task List

- [ ] auth-api
- [ ] tasks-api
- [ ] users-api
- [ ] DynamoDB
- [ ] Terraform Docs
- [ ] TerraformLint
- [ ] IAM Roles
- [ ] GitHub Actions
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>5.73.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_name"></a> [eks\_name](#input\_eks\_name) | Name to be used on all the resources as identifier | `string` | `"eks"` | no |
| <a name="input_env"></a> [env](#input\_env) | Default environment | `string` | `"dev"` | no |
| <a name="input_region"></a> [region](#input\_region) | Default region | `string` | `"us-west-2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags | `map(string)` | <pre>{<br/>  "Environment": "dev"<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->