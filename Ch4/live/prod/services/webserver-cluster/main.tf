provider "aws" {
  region = "us-west-1"
}

module "webserver_cluster" {
  source                 = "../../../../modules/services/webserver-cluster"
  cluster_name           = "web-prod"
  db_remote_state_bucket = "sharg-terraform-up-and-running"
  db_remote_state_key    = "prod/datastores/mysql/terraform.tfstate"
  instance_type          = "t2.micro"
  min_size               = 3
  max_size               = 5
  enable_autoscaling	 = true
  enable_new_userdata    = false
}

terraform {
  backend "s3" {
    bucket = "sharg-terraform-up-and-running"
    key    = "prod/services/webserver-cluster/terraform.tfstate"
    region = "us-west-1"

    dynamodb_table = "shargool-terraform-up-and-running-locks"
    encrypt        = true
  }
}
