output "alb_dns_name" {
  value       = module.webserver_cluster.public_dns
  description = "The domain name of the load balancer"
}
