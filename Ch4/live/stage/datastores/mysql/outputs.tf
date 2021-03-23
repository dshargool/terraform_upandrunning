output "db_address" {
  value       = module.db_instance.db_address
  description = "MySQL Database Address"
}

output "port" {
  value       = module.db_instance.port
  description = "MySQL Database Listening Port"
}
