output "public_dns" {
  value       = aws_lb.example.dns_name
  description = "Public DNS for the load balancer"
}

output "asg_name" {
  value       = aws_autoscaling_group.example.name
  description = "The name of the Auto Scaling Group"
}
