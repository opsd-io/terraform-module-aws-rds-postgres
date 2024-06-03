variable "allocated_storage" {
  description = "A size of the DB storage."
  type        = number
  default     = 20
}

variable "auto_minor_version_upgrade" {
  description = "Enables minor version auto upgrade."
  type        = bool
  default     = false
}

variable "availability_zone" {
  description = "The availability zone of the instance."
  type        = string
  default     = null
}

variable "backup_retention_period" {
  description = "The days to retain backups for."
  type        = number
  default     = 1
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled."
  type        = string
  default     = "03:00-06:00"
}

variable "blue_green_update_enabled" {
  description = "Enables low-downtime updates when true."
  type        = bool
  default     = false
}

variable "ca_cert_identifier" {
  description = "The identifier of the CA certificate for the DB instance."
  type        = string
  default     = null
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Instance tags to snapshots."
  type        = bool
  default     = false
}

variable "custom_iam_instance_profile" {
  description = "The instance profile associated with the underlying Amazon EC2 instance of an RDS Custom DB instance."
  type        = string
  default     = null
}

variable "db_name" {
  description = "The database name."
  type        = string
  default     = "defaultdb"
}

variable "db_subnet_group_name" {
  description = "The name of DB subnet group."
  type        = string
  default     = null
}

variable "dedicated_log_volume" {
  description = "Use a dedicated log volume (DLV) for the DB instance."
  type        = bool
  default     = false
}

variable "delete_automated_backups" {
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted."
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  type        = bool
  default     = false
}

variable "enabled_cloudwatch_logs_exports" {
  description = "value"
  type        = set(string)
  default     = null
}

variable "engine_version" {
  description = "The engine version to use."
  type        = string
  default     = "16.3"
}

variable "final_snapshot_identifier" {
  description = "he name of your final DB snapshot when this DB instance is deleted."
  type        = string
  default     = null
}

variable "iam_database_authentication_enabled" {
  description = "Enables mappings of AWS IAM accounts to database accounts."
  type        = bool
  default     = false
}

variable "instance_class" {
  description = "The instance type of the RDS instance."
  type        = string
  default     = "db.t4g.micro"
}

variable "instance_name" {
  description = "The database instance identifier."
  type        = string
}

variable "iops" {
  description = "The database storage type."
  type        = number
  default     = null
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key."
  type        = string
  default     = null
}

variable "maintenance_window" {
  description = "The window to perform maintenance in."
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "manage_master_user_password" {
  description = "Set to true to allow RDS to manage the master user password in Secrets Manager."
  type        = bool
  default     = null
}

variable "max_allocated_storage" {
  description = "The upper limit to which Amazon RDS can automatically scale the storage of the DB instance."
  type        = number
  default     = 0
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance."
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ."
  type        = bool
  default     = false
}

variable "network_type" {
  description = "The network type of the DB instance."
  type        = string
  default     = "IPV4"
}

variable "parameter_group_family" {
  description = "The family of the DB parameter group."
  type        = string
  default     = "postgres16"
}

variable "parameter_group_name" {
  description = "The name of the database parameter group."
  type        = string
  default     = null
}

variable "parameter_group_list" {
  description = "A list of parameters included in the database parameter group."
  type        = list(map(string))
  default     = []
}

variable "password" {
  description = "Password for the master DB user."
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled."
  type        = bool
  default     = false
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data."
  type        = string
  default     = null
}

variable "performance_insights_retention_period" {
  description = "Amount of time in days to retain Performance Insights data."
  type        = number
  default     = 0
}

variable "port" {
  description = "The port on which the DB accepts connections."
  type        = number
  default     = 5432
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible."
  type        = bool
  default     = false
}

variable "replica_enabled" {
  description = "If true, the DB replica is created."
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted."
  type        = bool
  default     = true
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot."
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "A set of subnet IDs used to create DB subnet group."
  type        = set(string)
  default     = []
}

variable "storage_encrypted" {
  description = "The storage throughput value for the DB instance."
  type        = bool
  default     = false
}

variable "storage_throughput" {
  description = "The storage throughput value for the DB instance."
  type        = number
  default     = null
}

variable "storage_type" {
  description = "The database storage type."
  type        = string
  default     = "gp3"
}

variable "tags" {
  description = "A map of tags."
  type        = map(string)
  default     = {}
}

variable "username" {
  description = "Username for the master DB user."
  type        = string
  default     = "dbadmin"
}

variable "vpc_security_group_ids" {
  description = "The database storage type."
  type        = list(string)
  default     = []
}

# Replica

variable "replica_availability_zone" {
  description = "The availability zone of the replica instance."
  type        = string
  default     = null
}

variable "replica_name" {
  description = "The replica instance identifier."
  type        = string
  default     = null
}

variable "number_of_replicas" {
  description = "Allows creating arbitrary number of replicas."
  type        = number
  default     = 0
}
