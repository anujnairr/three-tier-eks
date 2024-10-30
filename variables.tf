
variable "region" {
  default     = "us-west-2"
  type        = string
  description = "Default region"
}

variable "env" {
  default     = "dev"
  type        = string
  description = "Default environment"
}

variable "tags" {
  default = {
    "Name"        = ""
    "Environment" = "dev"
  }
  description = "A map of tags"
  type        = map(string)
}


# variable "tags" {
#   description = "A map of tags to add to all resources"
#   type        = map(string)
#   default = {
#     "Project"     = "TerraformEKSWorkshop"
#     "Environment" = "Development"
#     "Owner"       = "Ashish Patel"
#   }
# }


#project - "tkeworkshop"
variable "eks_name" {
  default     = "eks"
  description = "Name to be used on all the resources as identifier"
  type        = string
}
