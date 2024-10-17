locals {
    common_tags = {
    Env = "Dev"
    Team = "DevOps"
    }
}

variable "ec2_names" {
  default = ["web-1","web-2","web-3"]
}

variable "az" {
  default = ["us-west-2a","us-west-2b","us-west-2c"]
}
