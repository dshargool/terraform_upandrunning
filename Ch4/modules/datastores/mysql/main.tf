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

resource "aws_db_instance" "example" {
  identifier_prefix   = "${var.db_prefix}-terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "${var.db_prefix}_example_database"
  username            = "admin"
  password            = var.db_password
  skip_final_snapshot = true
}
