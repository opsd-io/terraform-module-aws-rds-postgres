resource "aws_db_parameter_group" "main" {
  count = var.create_db_parameter_group ? 1 : 0

  name   = var.parameter_group_name
  family = "postgres16"

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_instance" "main" {
  allocated_storage           = var.allocated_storage
  identifier                  = var.instance_name
  db_name                     = var.db_name
  engine                      = "postgres"
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  manage_master_user_password = var.manage_master_user_password
  username                    = var.username
  password                    = var.password
  parameter_group_name        = var.parameter_group_name

  max_allocated_storage = var.max_allocated_storage
  db_subnet_group_name  = var.db_subnet_group_name
  multi_az              = var.multi_az

  # replicate_source_db = var.replicate_source_db

  storage_type = var.storage_type
  # iops         = var.iops

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  # enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  # must be grater than 0 if the db is used as a source for read replica
  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false

  auto_minor_version_upgrade = false

  # performance_insights_enabled          = true
  # performance_insights_retention_period = 7
  # monitoring_interval                   = 60

  tags = var.tags
}
