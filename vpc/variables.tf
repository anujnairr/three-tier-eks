
variable "region" {}
variable "env" {}
variable "eks_name" {}
variable "tags" {}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "Default VPC CIDR"
}

variable "subnet_cidr_bits" {
  default     = 8
  type        = number
  description = "The number of subnet bits for the CIDR. For example, specifying a value 8 for this parameter will create a CIDR with a mask of /24"
}

variable "az_count" {
  default     = 2
  type        = number
  description = "The number of AZs for HA"
}
