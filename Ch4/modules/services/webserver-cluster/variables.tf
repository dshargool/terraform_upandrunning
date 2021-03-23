variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote status"
  type        = string
}

variable "db_remote_state_key" {
  description = "the Path for the database's remote state in S3"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type to run (ex t2.micro)"
  type        = string
}

variable "min_size" {
  description = "Minimum number of instances in ASG"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in ASG"
  type        = number
}