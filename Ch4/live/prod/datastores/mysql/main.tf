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

module "db_instance" {
  source = "../../../modules/datastores/mysql"
    db_prefix = "prod"
    db_password = var.db_password
}

terraform {
  backend "s3" {
    bucket = "sharg-terraform-up-and-running"
    key    = "prod/datastores/mysql/terraform.tfstate"
    region = "us-west-1"

    dynamodb_table = "shargool-terraform-up-and-running-locks"
    encrypt        = true
  }
}
