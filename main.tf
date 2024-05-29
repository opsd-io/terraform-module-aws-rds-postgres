terraform {
  required_version = ">= 1.5.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.50.0"
    }
  }
}

provider "aws" {}

resource "aws_db_parameter_group" "main" {
  count = var.create_db_parameter_group ? 1 : 0

  name   = var.parameter_group_name
  family = "postgres16"

  dynamic "parameter" {
    for_each = var.parameters_map
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
  allocated_storage          = var.allocated_storage
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  availability_zone          = var.availability_zone
  backup_retention_period    = var.backup_retention_period
  backup_window              = var.backup_window

  blue_green_update {
    enabled = var.blue_green_update_enabled
  }

  ca_cert_identifier                    = var.ca_cert_identifier
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  custom_iam_instance_profile           = var.custom_iam_instance_profile
  db_name                               = var.db_name
  db_subnet_group_name                  = var.db_subnet_group_name
  dedicated_log_volume                  = var.dedicated_log_volume
  delete_automated_backups              = var.delete_automated_backups
  deletion_protection                   = var.deletion_protection
  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports
  engine                                = "postgres"
  engine_version                        = var.engine_version
  final_snapshot_identifier             = var.final_snapshot_identifier
  iam_database_authentication_enabled   = var.iam_database_authentication_enabled
  instance_class                        = var.instance_class
  identifier                            = var.instance_name
  iops                                  = var.iops
  kms_key_id                            = var.kms_key_id
  maintenance_window                    = var.maintenance_window
  manage_master_user_password           = var.manage_master_user_password
  max_allocated_storage                 = var.max_allocated_storage
  monitoring_interval                   = var.monitoring_interval
  monitoring_role_arn                   = var.monitoring_role_arn
  multi_az                              = var.multi_az
  network_type                          = var.network_type
  parameter_group_name                  = var.parameter_group_name
  password                              = var.password
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = var.performance_insights_kms_key_id
  performance_insights_retention_period = var.performance_insights_retention_period
  port                                  = var.port
  publicly_accessible                   = var.publicly_accessible
  skip_final_snapshot                   = var.skip_final_snapshot
  snapshot_identifier                   = var.snapshot_identifier
  storage_encrypted                     = var.storage_encrypted
  storage_throughput                    = var.storage_throughput
  storage_type                          = var.storage_type
  tags                                  = var.tags
  username                              = var.username
  vpc_security_group_ids                = var.vpc_security_group_ids
}

resource "aws_db_instance" "replica" {
  count                      = var.replica_enabled ? 1 : 0
  replicate_source_db        = aws_db_instance.main.identifier
  instance_class             = var.instance_class
  availability_zone          = var.replica_availability_zone
  identifier                 = var.replica_name != null ? var.replica_name : "${var.instance_name}-replica"
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  skip_final_snapshot        = var.skip_final_snapshot
  tags                       = var.tags
}
