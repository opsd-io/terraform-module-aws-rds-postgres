output "db_instance_address" {
  description = "The address of the RDS instance."
  value       = aws_db_instance.main.address
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance."
  value       = aws_db_instance.main.arn
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance."
  value       = aws_db_instance.main.availability_zone
}

output "db_instance_backup_retention_period" {
  description = "The backup window of the RDS instance."
  value       = aws_db_instance.main.backup_retention_period
}

output "db_instance_backup_window" {
  description = "The backup retention period of the RDS instance."
  value       = aws_db_instance.main.backup_window
}

output "db_instance_endpoint" {
  description = "The connection endpoint of the RDS instance."
  value       = aws_db_instance.main.endpoint
}

output "db_instance_identifier" {
  description = "The RDS instance identifier."
  value       = aws_db_instance.main.identifier
}

output "db_instance_engine_version_actual" {
  description = "The running version of the RDS instance."
  value       = aws_db_instance.main.engine_version_actual
}

output "db_instance_maintenance_window" {
  description = "The maintenance window of the RDS instance."
  value       = aws_db_instance.main.maintenance_window
}

output "db_instance_status" {
  description = "The status of the RDS instance."
  value       = aws_db_instance.main.status
}

output "db_instance_replica_availability_zone" {
  description = "The availability zone of the replica instance."
  value       = length(aws_db_instance.replica) > 0 ? aws_db_instance.replica[0].availability_zone : null
}
