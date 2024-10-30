
module "vpc" {
  source   = "./vpc"
  env      = var.env
  region   = var.region
  eks_name = var.eks_name
  tags     = var.tags
}
