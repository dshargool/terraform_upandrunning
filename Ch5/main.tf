terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.29.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-west-1"
}

resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name = each.value
}

variable "user_names" {
  description = "User names for IAM users"
  type = list(string)
  default = ["neo", "morpheus", "trinity"]
}

variable "hero_thousand_faces" {
  description = "map"
  type = map(string)
  default = {
    neo = "hero"
    trinity = "love interest"
    morpheus = "mentor"
}
}

terraform {
  backend "s3" {
    bucket = "sharg-terraform-up-and-running"
    key    = "ch5/examples/terraform.tfstate"
    region = "us-west-1"

    dynamodb_table = "shargool-terraform-up-and-running-locks"
    encrypt        = true
  }
}
