provider "aws" {
  region = "us-west-1"
}

module "webserver_cluster" {
  source                 = "../../../../modules/services/webserver-cluster/"
  cluster_name           = "web-stage"
  db_remote_state_bucket = "sharg-terraform-up-and-running"
  db_remote_state_key    = "stage/datastores/mysql/terraform.tfstate"
  instance_type          = "t2.micro"
  min_size               = 1
  max_size               = 2
  enable_autoscaling     = false
  server_text            = "Super Mario World!"
  ami                    = "ami-04468e03c37242e1e"
}


terraform {
  backend "s3" {
    bucket = "sharg-terraform-up-and-running"
    key    = "stage/services/webserver-cluster/terraform.tfstate"
    region = "us-west-1"

    dynamodb_table = "shargool-terraform-up-and-running-locks"
    encrypt        = true
  }
}
