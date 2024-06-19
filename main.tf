terraform {
  required_version = ">= 1.5.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.50.0"
    }
  }
}

locals {
  db_subnet_group_name = var.db_subnet_group_name != null ? var.db_subnet_group_name : (length(var.subnet_ids) > 0 ? var.instance_name : null)
  parameter_group_name = var.parameter_group_name != null ? var.parameter_group_name : (length(var.parameter_group_list) > 0 ? var.instance_name : null)

  backup_retention_period = var.blue_green_update_enabled ? coalesce(var.backup_retention_period, 1) : var.backup_retention_period
}

resource "aws_db_parameter_group" "main" {
  count = length(var.parameter_group_list) > 0 ? 1 : 0

  name   = local.parameter_group_name
  family = var.parameter_group_family
  tags   = merge(var.common_tags, var.parameter_group_tags)

  dynamic "parameter" {
    for_each = var.parameter_group_list
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

resource "aws_db_subnet_group" "main" {
  count = var.subnet_ids != null && try(length(var.subnet_ids) > 0) ? 1 : 0

  name       = local.db_subnet_group_name
  subnet_ids = var.subnet_ids
  tags       = merge(var.common_tags, var.db_subnet_group_tags)
}

resource "aws_db_instance" "main" {
  allocated_storage          = var.allocated_storage
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  availability_zone          = var.availability_zone
  backup_retention_period    = local.backup_retention_period
  backup_window              = var.backup_window

  blue_green_update {
    enabled = var.blue_green_update_enabled
  }

  ca_cert_identifier                    = var.ca_cert_identifier
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  custom_iam_instance_profile           = var.custom_iam_instance_profile
  db_name                               = var.db_name
  db_subnet_group_name                  = local.db_subnet_group_name
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
  parameter_group_name                  = local.parameter_group_name
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
  tags = merge(
    var.common_tags,
    var.instance_tags,
    { Name = var.instance_name },
    var.tags
  )
  username               = var.username
  vpc_security_group_ids = var.vpc_security_group_ids

  dynamic "restore_to_point_in_time" {
    for_each = var.snapshot_identifier == null && length(var.restore_to_point_in_time) > 0 ? [1] : []

    content {
      restore_time                             = lookup(var.restore_to_point_in_time, "restore_time", null)
      source_db_instance_identifier            = lookup(var.restore_to_point_in_time, "source_db_instance_identifier", null)
      source_db_instance_automated_backups_arn = lookup(var.restore_to_point_in_time, "source_db_instance_automated_backups_arn", null)
      source_dbi_resource_id                   = lookup(var.restore_to_point_in_time, "source_dbi_resource_id", null)
      use_latest_restorable_time               = lookup(var.restore_to_point_in_time, "use_latest_restorable_time", null)
    }
  }

  lifecycle {
    ignore_changes = [
      snapshot_identifier
    ]
  }

  timeouts {
    create = var.timeouts.create
    update = var.timeouts.update
    delete = var.timeouts.delete
  }
}

resource "aws_db_instance_role_association" "main" {
  for_each = var.role_associations

  db_instance_identifier = aws_db_instance.main.identifier
  feature_name           = each.key
  role_arn               = each.value
}

resource "aws_db_instance" "replica" {
  count = var.replica_enabled ? 1 : 0

  replicate_source_db        = aws_db_instance.main.identifier
  instance_class             = var.instance_class
  availability_zone          = var.replica_availability_zone
  identifier                 = var.replica_name != null ? var.replica_name : "${var.instance_name}-replica"
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  skip_final_snapshot        = var.skip_final_snapshot
  tags = merge(
    var.common_tags,
    var.instance_tags,
    { Name = var.replica_name != null ? var.replica_name : "${var.instance_name}-replica" },
    var.replica_tags
  )
}

resource "aws_db_instance" "multi_replica" {
  count = var.number_of_replicas

  replicate_source_db        = aws_db_instance.main.identifier
  instance_class             = var.instance_class
  identifier                 = var.replica_name != null ? "${var.replica_name}-${count.index + 1}" : "${var.instance_name}-replica-${count.index + 1}"
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  skip_final_snapshot        = var.skip_final_snapshot
  tags = merge(
    var.common_tags,
    var.instance_tags,
    { Name = var.replica_name != null ? "${var.replica_name}-${count.index + 1}" : "${var.instance_name}-replica-${count.index + 1}" },
    var.replica_tags
  )
}

resource "aws_db_instance" "custom_replica" {
  for_each = var.custom_replicas

  replicate_source_db        = aws_db_instance.main.identifier
  instance_class             = try(each.value.instance_class)
  availability_zone          = try(each.value.availability_zone)
  identifier                 = each.key
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  skip_final_snapshot        = var.skip_final_snapshot
  tags = merge(
    var.common_tags,
    var.instance_tags,
    { Name = each.key },
    var.replica_tags,
    try(each.value.tags, {})
  )
}
