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

resource "aws_instance" "web_server" {
  ami                    = "ami-005c06c6de69aee84"
  instance_type          = "t2.micro"
#  vpc_security_group_ids = [aws_security_group.instance.id]

  tags = {
    Name = "terraform-example-${terraform.workspace}"
  }

  user_data = <<-EOF
  	      #!/bin/bash
  	      yum -y update
	      yum -y install httpd
  	      systemctl enable httpd
	      systemctl start httpd
  	      echo 'Hello world!' > /var/www/html/index.html 
  	      EOF

}
#resource "aws_security_group" "instance" {
#  name = "terraform-example-instance"
#  ingress {
#    from_port   = var.server_port
#    to_port     = var.server_port
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  #ingress {
#  #  from_port   = 22
#  #  to_port     = 22
#  #  protocol    = "tcp"
#  #  cidr_blocks = ["0.0.0.0/0"]
#  #}
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}
#resource "aws_s3_bucket" "terraform_state" {
#  bucket = "sharg-terraform-up-and-running"
#  lifecycle {
#    #    prevent_destroy = true
#  }
#
#  versioning {
#    enabled = true
#  }
#
#  server_side_encryption_configuration {
#    rule {
#      apply_server_side_encryption_by_default {
#        sse_algorithm = "AES256"
#      }
#    }
#
#  }
#}
#
#resource "aws_dynamodb_table" "terraform_locks" {
#  name         = "shargool-terraform-up-and-running-locks"
#  billing_mode = "PAY_PER_REQUEST"
#  hash_key     = "LockID"
#
#  attribute {
#    name = "LockID"
#    type = "S"
#  }
#}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}

#terraform {
#  backend "s3" {
#    bucket = "sharg-terraform-up-and-running"
#    key    = "workspaces-example/terraform.tfstate"
#    region = "us-west-1"
#
#    dynamodb_table = "shargool-terraform-up-and-running-locks"
#    encrypt        = true
#  }
#}
