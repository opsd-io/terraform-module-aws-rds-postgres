variable "allocated_storage" {
  description = "A size of the DB storage."
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "The upper limit to which Amazon RDS can automatically scale the storage of the DB instance."
  type        = number
  default     = null
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "instance_name" {
  description = "The database instance identifier."
  type        = string
}

variable "db_name" {
  description = "The database name."
  type        = string
  default     = "defaultdb"
}

variable "engine_version" {
  description = "The engine version to use."
  type        = string
  default     = "16.3"
}

variable "availability_zone" {
  description = "The availability zone of the instance"
  type        = string
  default     = null
}

variable "instance_class" {
  description = "The instance type of the RDS instance."
  type        = string
  default     = "db.t4g.micro"
}

variable "password" {
  description = "Password for the master DB user."
  type        = string
  default     = null
}

variable "manage_master_user_password" {
  type    = bool
  default = null
}

variable "username" {
  description = "Username for the master DB user."
  type        = string
  default     = "dbadmin"
}

###

variable "create_mode" {
  description = "The creation mode. Can be used to restore or replicate existing servers."
  type        = string
  default     = "Default"
}

variable "creation_source_server_id" {
  description = "For creation modes other then default the source server ID to use."
  type        = string
  default     = null
}

variable "restore_point_in_time" {
  description = "When create_mode is PointInTimeRestore the point in time to restore from creation_source_server_id."
  type        = string
  default     = null
}

variable "create_db_parameter_group" {
  description = "If true, a database parameter group is created."
  type        = bool
  default     = true
}

variable "parameter_group_name" {
  description = "The name of the database parameter group."
  type        = string
  default     = null
}

variable "parameters" {
  description = "A map of parameters included in the database parameter group."
  default     = {}
}

variable "replicate_source_db" {
  description = "Specifies that this a Replicate database."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags."
  type        = map(string)
  default     = {}
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group."
  type        = string
  default     = null
}


variable "storage_type" {
  description = "The database storage type."
  type        = string
  default     = "gp3"
}

variable "iops" {
  description = "The database storage type."
  type        = number
  default     = 3000
}