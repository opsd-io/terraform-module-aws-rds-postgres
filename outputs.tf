output "subnet_group_id" {
  value       = one(aws_db_subnet_group.main[*].id)
  description = "The ID of the DB subnet Group."
}

output "parameter_group_id" {
  value       = one(aws_db_parameter_group.main[*].id)
  description = "The ID of the DB parameter group."
}

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

output "db_instance_resource_id" {
  description = "The Resource ID of the RDS instance."
  value       = aws_db_instance.main.resource_id
}

output "db_instance_status" {
  description = "The status of the RDS instance."
  value       = aws_db_instance.main.status
}

#
# Replication - Single replica instance
#

output "db_instance_replica_address" {
  description = "The address of the replica instance."
  value       = one(aws_db_instance.replica[*].address)
}

output "db_instance_replica_arn" {
  description = "The ARN of the replica instance."
  value       = one(aws_db_instance.replica[*].arn)
}

output "db_instance_replica_availability_zone" {
  description = "The availability zone of the replica instance."
  value       = one(aws_db_instance.replica[*].availability_zone)
}

output "db_instance_replica_backup_retention_period" {
  description = "The backup window of the replica instance."
  value       = one(aws_db_instance.replica[*].backup_retention_period)
}

output "db_instance_replica_backup_window" {
  description = "The backup retention period of the replica instance."
  value       = one(aws_db_instance.replica[*].backup_window)
}

output "db_instance_replica_endpoint" {
  description = "The connection endpoint of the replica instance."
  value       = one(aws_db_instance.replica[*].endpoint)
}

output "db_instance_replica_identifier" {
  description = "The replica instance identifier."
  value       = one(aws_db_instance.replica[*].identifier)
}

output "db_instance_replica_engine_version_actual" {
  description = "The running version of the replica instance."
  value       = one(aws_db_instance.replica[*].engine_version_actual)
}

output "db_instance_replica_maintenance_window" {
  description = "The maintenance window of the replica instance."
  value       = one(aws_db_instance.replica[*].maintenance_window)
}

output "db_instance_replica_resource_id" {
  description = "The Resource ID of the replica instance."
  value       = one(aws_db_instance.replica[*].resource_id)
}

output "db_instance_replica_status" {
  description = "The status of the replica instance."
  value       = one(aws_db_instance.replica[*].status)
}

#
# Replication - Simple mode
#

output "db_multi_replica_address" {
  description = "The address of the replica instance."
  value       = { for r in aws_db_instance.multi_replica : r.identifier => r.address }
}

output "db_multi_replica_arn" {
  description = "The ARN of the replica instance."
  value       = { for r in aws_db_instance.multi_replica : r.identifier => r.arn }
}

output "db_multi_replica_availability_zone" {
  description = "The availability zone of the replica instance."
  value       = { for r in aws_db_instance.multi_replica : r.identifier => r.availability_zone }
}

output "db_multi_replica_backup_retention_period" {
  description = "The backup window of the replica instance."
  value       = { for r in aws_db_instance.multi_replica : r.identifier => r.backup_retention_period }
}

output "db_multi_replica_backup_window" {
  description = "The backup retention period of the replica instance."
  value       = { for r in aws_db_instance.multi_replica : r.identifier => r.backup_window }
}

output "db_multi_replica_endpoint" {
  description = "The connection endpoint of the replica instance."
  value       = { for r in aws_db_instance.multi_replica : r.identifier => r.endpoint }
}

output "db_multi_replica_identifier" {
  description = "The replica instance identifier."
  value       = [for r in aws_db_instance.multi_replica : r.identifier]
}

output "db_multi_replica_engine_version_actual" {
  description = "The running version of the replica instance."
  value       = { for r in aws_db_instance.multi_replica : r.identifier => r.engine_version_actual }
}

output "db_multi_replica_maintenance_window" {
  description = "The maintenance window of the replica instance."
  value       = { for r in aws_db_instance.multi_replica : r.identifier => r.maintenance_window }
}

output "db_multi_replica_resource_id" {
  description = "The Resource ID of the replica instance."
  value       = { for r in aws_db_instance.multi_replica : r.identifier => r.resource_id }
}

output "db_multi_replica_status" {
  description = "The status of the replica instance."
  value       = { for r in aws_db_instance.multi_replica : r.identifier => r.status }
}

#
# Replication - Advanced mode
#

output "db_custom_replica_address" {
  description = "The address of the replica instance."
  value       = { for r in aws_db_instance.custom_replica : r.identifier => r.address }
}

output "db_custom_replica_arn" {
  description = "The ARN of the replica instance."
  value       = { for r in aws_db_instance.custom_replica : r.identifier => r.arn }
}

output "db_custom_replica_availability_zone" {
  description = "The availability zone of the replica instance."
  value       = { for r in aws_db_instance.custom_replica : r.identifier => r.availability_zone }
}

output "db_custom_replica_backup_retention_period" {
  description = "The backup window of the replica instance."
  value       = { for r in aws_db_instance.custom_replica : r.identifier => r.backup_retention_period }
}

output "db_custom_replica_backup_window" {
  description = "The backup retention period of the replica instance."
  value       = { for r in aws_db_instance.custom_replica : r.identifier => r.backup_window }
}

output "db_custom_replica_endpoint" {
  description = "The connection endpoint of the replica instance."
  value       = { for r in aws_db_instance.custom_replica : r.identifier => r.endpoint }
}

output "db_custom_replica_identifier" {
  description = "The replica instance identifier."
  value       = [for r in aws_db_instance.custom_replica : r.identifier]
}

output "db_custom_replica_engine_version_actual" {
  description = "The running version of the replica instance."
  value       = { for r in aws_db_instance.custom_replica : r.identifier => r.engine_version_actual }
}

output "db_custom_replica_maintenance_window" {
  description = "The maintenance window of the replica instance."
  value       = { for r in aws_db_instance.custom_replica : r.identifier => r.maintenance_window }
}

output "db_custom_replica_resource_id" {
  description = "The Resource ID of the replica instance."
  value       = { for r in aws_db_instance.custom_replica : r.identifier => r.resource_id }
}

output "db_custom_replica_status" {
  description = "The status of the replica instance."
  value       = { for r in aws_db_instance.custom_replica : r.identifier => r.status }
}
