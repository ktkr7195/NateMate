variable "aws_access_key" {}
variable "aws_secret_key" {}

terraform {
  required_version = "=0.12.19"
}

provider "aws" {
  region     = "ap-northeast-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

#ses用プロバイダー
provider "aws" {
  alias      = "south"
  region     = "ap-south-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}