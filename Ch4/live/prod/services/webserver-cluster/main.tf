provider "aws" {
  region = "us-west-1"
}

module "webserver_cluster" {
  source                 = "../../../modules/services/webserver-cluster"
  cluster_name           = "web-prod"
  db_remote_state_bucket = "sharg-terraform-up-and-running"
  db_remote_state_key    = "prod/datastores/mysql/terraform.tfstate"
  instance_type          = "t2.micro"
  min_size               = 1
  max_size               = 3
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  autoscaling_group_name = module.webserver_cluster.asg_name
  schedule_action_name   = "scale-out-during-business-hours"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 10
  recurrence             = "0 9 * * *"
}

resource "aws_autoscaling_schedule" "scale_in_after_business_hours" {
  autoscaling_group_name = module.webserver_cluster.asg_name
  schedule_action_name   = "scale_in_after_business_hours"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 2
  recurrence             = "0 17 * * *"
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
