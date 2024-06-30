<a href="https://www.opsd.io" target="_blank"><img alt="OPSd" src=".github/img/OPSD_logo.svg" width="180px"></a>

Meet **OPSd**. The unique and effortless way of managing cloud infrastructure.

# terraform-module-aws-rds-postgres

## Introduction

Terraform module which creates RDS Postgres on AWS.

## Usage

```hcl
  source = "github.com/opsd-io/terraform-module-aws-rds-postgres"

  instance_name        = "example"
  engine_version       = "16.3"
  instance_class       = "db.t4g.micro"

  username = "dbadmin"
  password = "avoid-plaintext-passwords"

  tags = {
    "Name" = "example"
    "Env"  = "test"
  }
}
```

**IMPORTANT**: Make sure not to pin to master because there may be breaking changes between releases.

## Tags

* ```var.common_tags``` - assigned to every resource in this module
* ```var.instance_tags``` - assigned to the DB instance and each of it's replicas
* ```var.tags``` - assigned to the DB instance
* ```var.replica_tags``` - assigned to every DB replica instance
* ```var.db_subnet_group_tags``` - assigned to the DB subnet group
* ```var.parameter_group_tags``` - assigned to the DB parameter group

## Replication
The module allows to create replica instance(s) in three different ways:

1. Single replica instance
```hcl
module "postgres_main" {
  source = "github.com/opsd-io/terraform-module-aws-rds-postgres"
  (...)
  replica_enabled = true
}
```

2. Simple mode - an option to create arbitrary number of replicas. It's not possible to set distinct settings for each instance.

```hcl
module "postgres_main" {
  source = "github.com/opsd-io/terraform-module-aws-rds-postgres"
  (...)
  number_of_replicas = 3
}
```

3. Advanced mode - an option to create arbitrary number of replicas alongwith different settings for each instance. Offers the highest flexibility.

```hcl
module "postgres_main" {
  source = "github.com/opsd-io/terraform-module-aws-rds-postgres"
  (...)
  custom_replicas = {
    "opsd-postgres-main-read-${var.env_name}" = {
      "availability_zone" = "us-east-2b"
      "tags" = { "replica" = "read" }
    }
    "opsd-postgres-main-analytics-${var.env_name}" = {
      "availability_zone" = "us-east-2c"
      "instance_class"    = "db.t4g.small"
      "tags" = { "replica" = "analytics" }
    }
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.50.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.50.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.postgres](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.postgres_custom_replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.postgres_multi_replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.postgres_replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_db_instance.custom_replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_instance.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_instance.multi_replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_instance.replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_instance_role_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance_role_association) | resource |
| [aws_db_parameter_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | A size of the DB storage. | `number` | `20` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Enables minor version auto upgrade. | `bool` | `false` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The availability zone of the instance. | `string` | `null` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for. | `number` | `null` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | The daily time range (in UTC) during which automated backups are created if they are enabled. | `string` | `"03:00-06:00"` | no |
| <a name="input_blue_green_update_enabled"></a> [blue\_green\_update\_enabled](#input\_blue\_green\_update\_enabled) | Enables low-downtime updates when true. | `bool` | `false` | no |
| <a name="input_ca_cert_identifier"></a> [ca\_cert\_identifier](#input\_ca\_cert\_identifier) | The identifier of the CA certificate for the DB instance. | `string` | `null` | no |
| <a name="input_cloudwatch_log_group_class"></a> [cloudwatch\_log\_group\_class](#input\_cloudwatch\_log\_group\_class) | The log class of the log group. | `string` | `"STANDARD"` | no |
| <a name="input_cloudwatch_log_group_kms_key_id"></a> [cloudwatch\_log\_group\_kms\_key\_id](#input\_cloudwatch\_log\_group\_kms\_key\_id) | The ARN of the KMS Key to use when encrypting log data. | `string` | `null` | no |
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | Tthe number of days to retain log events in the cloudwatch log group. | `number` | `7` | no |
| <a name="input_cloudwatch_log_group_skip_destroy"></a> [cloudwatch\_log\_group\_skip\_destroy](#input\_cloudwatch\_log\_group\_skip\_destroy) | Set to true to prevent deletion fo the log group at terraform destroy time. | `bool` | `false` | no |
| <a name="input_cloudwatch_logs_enabled"></a> [cloudwatch\_logs\_enabled](#input\_cloudwatch\_logs\_enabled) | If true, cloudwatch log group is created. | `bool` | `false` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A map of tags to assign to every resource in this module. | `map(string)` | `{}` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | Copy all Instance tags to snapshots. | `bool` | `false` | no |
| <a name="input_custom_iam_instance_profile"></a> [custom\_iam\_instance\_profile](#input\_custom\_iam\_instance\_profile) | The instance profile associated with the underlying Amazon EC2 instance of an RDS Custom DB instance. | `string` | `null` | no |
| <a name="input_custom_replicas"></a> [custom\_replicas](#input\_custom\_replicas) | A map of replica instances. Allows to set different settings for each one. | <pre>map(object({<br>    availability_zone = optional(string),<br>    instance_class    = optional(string, "db.t4g.micro"),<br>    tags              = optional(map(string))<br>  }))</pre> | `{}` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The database name. | `string` | `"defaultdb"` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | The name of DB subnet group. | `string` | `null` | no |
| <a name="input_db_subnet_group_tags"></a> [db\_subnet\_group\_tags](#input\_db\_subnet\_group\_tags) | A map of the DB subnet group tags. | `map(string)` | `{}` | no |
| <a name="input_dedicated_log_volume"></a> [dedicated\_log\_volume](#input\_dedicated\_log\_volume) | Use a dedicated log volume (DLV) for the DB instance. | `bool` | `false` | no |
| <a name="input_delete_automated_backups"></a> [delete\_automated\_backups](#input\_delete\_automated\_backups) | Specifies whether to remove automated backups immediately after the DB instance is deleted. | `bool` | `true` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | The database can't be deleted when this value is set to true. | `bool` | `false` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | Set of log types to enable for exporting to CloudWatch logs. | `set(string)` | <pre>[<br>  "postgresql",<br>  "upgrade"<br>]</pre> | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version to use. | `string` | `"16.3"` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | he name of your final DB snapshot when this DB instance is deleted. | `string` | `null` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Enables mappings of AWS IAM accounts to database accounts. | `bool` | `false` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance type of the RDS instance. | `string` | `"db.t4g.micro"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The database instance identifier. | `string` | n/a | yes |
| <a name="input_instance_tags"></a> [instance\_tags](#input\_instance\_tags) | A map of tags to assign to the DB instance and each of it's replicas. | `map(string)` | `{}` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | The database storage type. | `number` | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key. | `string` | `null` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The window to perform maintenance in. | `string` | `"Mon:00:00-Mon:03:00"` | no |
| <a name="input_manage_master_user_password"></a> [manage\_master\_user\_password](#input\_manage\_master\_user\_password) | Set to true to allow RDS to manage the master user password in Secrets Manager. | `bool` | `null` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | The upper limit to which Amazon RDS can automatically scale the storage of the DB instance. | `number` | `0` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. | `number` | `0` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. | `string` | `null` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Specifies if the RDS instance is multi-AZ. | `bool` | `false` | no |
| <a name="input_network_type"></a> [network\_type](#input\_network\_type) | The network type of the DB instance. | `string` | `"IPV4"` | no |
| <a name="input_number_of_replicas"></a> [number\_of\_replicas](#input\_number\_of\_replicas) | Allows creating arbitrary number of replicas. | `number` | `0` | no |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | The family of the DB parameter group. | `string` | `"postgres16"` | no |
| <a name="input_parameter_group_list"></a> [parameter\_group\_list](#input\_parameter\_group\_list) | A list of parameters included in the database parameter group. | `list(map(string))` | `[]` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | The name of the database parameter group. | `string` | `null` | no |
| <a name="input_parameter_group_tags"></a> [parameter\_group\_tags](#input\_parameter\_group\_tags) | A map of the parameter group tags. | `map(string)` | `{}` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for the master DB user. | `string` | `null` | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Specifies whether Performance Insights are enabled. | `bool` | `false` | no |
| <a name="input_performance_insights_kms_key_id"></a> [performance\_insights\_kms\_key\_id](#input\_performance\_insights\_kms\_key\_id) | The ARN for the KMS key to encrypt Performance Insights data. | `string` | `null` | no |
| <a name="input_performance_insights_retention_period"></a> [performance\_insights\_retention\_period](#input\_performance\_insights\_retention\_period) | Amount of time in days to retain Performance Insights data. | `number` | `0` | no |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections. | `number` | `5432` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Bool to control if instance is publicly accessible. | `bool` | `false` | no |
| <a name="input_replica_availability_zone"></a> [replica\_availability\_zone](#input\_replica\_availability\_zone) | The availability zone of the replica instance. | `string` | `null` | no |
| <a name="input_replica_enabled"></a> [replica\_enabled](#input\_replica\_enabled) | If true, the DB replica is created. | `bool` | `false` | no |
| <a name="input_replica_name"></a> [replica\_name](#input\_replica\_name) | The replica instance identifier. | `string` | `null` | no |
| <a name="input_replica_tags"></a> [replica\_tags](#input\_replica\_tags) | A map of tags to assign to each replica instance. | `map(string)` | `{}` | no |
| <a name="input_restore_to_point_in_time"></a> [restore\_to\_point\_in\_time](#input\_restore\_to\_point\_in\_time) | value | <pre>object({<br>    restore_time                             = optional(string),<br>    source_db_instance_identifier            = optional(string),<br>    source_db_instance_automated_backups_arn = optional(string),<br>    source_dbi_resource_id                   = optional(string),<br>    use_latest_restorable_time               = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_role_associations"></a> [role\_associations](#input\_role\_associations) | A map of the database instance associations with an IAM Role. | `map(string)` | `{}` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB instance is deleted. | `bool` | `true` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this database from a snapshot. | `string` | `null` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | The storage throughput value for the DB instance. | `bool` | `false` | no |
| <a name="input_storage_throughput"></a> [storage\_throughput](#input\_storage\_throughput) | The storage throughput value for the DB instance. | `number` | `null` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | The database storage type. | `string` | `"gp3"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A set of subnet IDs used to create the DB subnet group. | `set(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of the DB instance tags. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | A map of timeouts to apply while creating, updating, or deleting the DB instance. | <pre>object({<br>    create = string<br>    update = string<br>    delete = string<br>  })</pre> | <pre>{<br>  "create": "40m",<br>  "delete": "60m",<br>  "update": "80m"<br>}</pre> | no |
| <a name="input_username"></a> [username](#input\_username) | Username for the master DB user. | `string` | `"dbadmin"` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | The database storage type. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_custom_replica_address"></a> [db\_custom\_replica\_address](#output\_db\_custom\_replica\_address) | The address of the replica instance (Advanced mode). |
| <a name="output_db_custom_replica_arn"></a> [db\_custom\_replica\_arn](#output\_db\_custom\_replica\_arn) | The ARN of the replica instance (Advanced mode). |
| <a name="output_db_custom_replica_availability_zone"></a> [db\_custom\_replica\_availability\_zone](#output\_db\_custom\_replica\_availability\_zone) | The availability zone of the replica instance (Advanced mode). |
| <a name="output_db_custom_replica_backup_retention_period"></a> [db\_custom\_replica\_backup\_retention\_period](#output\_db\_custom\_replica\_backup\_retention\_period) | The backup window of the replica instance (Advanced mode). |
| <a name="output_db_custom_replica_backup_window"></a> [db\_custom\_replica\_backup\_window](#output\_db\_custom\_replica\_backup\_window) | The backup retention period of the replica instance (Advanced mode). |
| <a name="output_db_custom_replica_endpoint"></a> [db\_custom\_replica\_endpoint](#output\_db\_custom\_replica\_endpoint) | The connection endpoint of the replica instance (Advanced mode). |
| <a name="output_db_custom_replica_engine_version_actual"></a> [db\_custom\_replica\_engine\_version\_actual](#output\_db\_custom\_replica\_engine\_version\_actual) | The running version of the replica instance (Advanced mode). |
| <a name="output_db_custom_replica_identifier"></a> [db\_custom\_replica\_identifier](#output\_db\_custom\_replica\_identifier) | The replica instance identifier (Advanced mode). |
| <a name="output_db_custom_replica_maintenance_window"></a> [db\_custom\_replica\_maintenance\_window](#output\_db\_custom\_replica\_maintenance\_window) | The maintenance window of the replica instance (Advanced mode). |
| <a name="output_db_custom_replica_resource_id"></a> [db\_custom\_replica\_resource\_id](#output\_db\_custom\_replica\_resource\_id) | The Resource ID of the replica instance (Advanced mode). |
| <a name="output_db_custom_replica_status"></a> [db\_custom\_replica\_status](#output\_db\_custom\_replica\_status) | The status of the replica instance (Advanced mode). |
| <a name="output_db_instance_address"></a> [db\_instance\_address](#output\_db\_instance\_address) | The address of the RDS instance. |
| <a name="output_db_instance_arn"></a> [db\_instance\_arn](#output\_db\_instance\_arn) | The ARN of the RDS instance. |
| <a name="output_db_instance_availability_zone"></a> [db\_instance\_availability\_zone](#output\_db\_instance\_availability\_zone) | The availability zone of the RDS instance. |
| <a name="output_db_instance_backup_retention_period"></a> [db\_instance\_backup\_retention\_period](#output\_db\_instance\_backup\_retention\_period) | The backup window of the RDS instance. |
| <a name="output_db_instance_backup_window"></a> [db\_instance\_backup\_window](#output\_db\_instance\_backup\_window) | The backup retention period of the RDS instance. |
| <a name="output_db_instance_endpoint"></a> [db\_instance\_endpoint](#output\_db\_instance\_endpoint) | The connection endpoint of the RDS instance. |
| <a name="output_db_instance_engine_version_actual"></a> [db\_instance\_engine\_version\_actual](#output\_db\_instance\_engine\_version\_actual) | The running version of the RDS instance. |
| <a name="output_db_instance_identifier"></a> [db\_instance\_identifier](#output\_db\_instance\_identifier) | The RDS instance identifier. |
| <a name="output_db_instance_maintenance_window"></a> [db\_instance\_maintenance\_window](#output\_db\_instance\_maintenance\_window) | The maintenance window of the RDS instance. |
| <a name="output_db_instance_replica_address"></a> [db\_instance\_replica\_address](#output\_db\_instance\_replica\_address) | The address of the replica instance. |
| <a name="output_db_instance_replica_arn"></a> [db\_instance\_replica\_arn](#output\_db\_instance\_replica\_arn) | The ARN of the replica instance. |
| <a name="output_db_instance_replica_availability_zone"></a> [db\_instance\_replica\_availability\_zone](#output\_db\_instance\_replica\_availability\_zone) | The availability zone of the replica instance. |
| <a name="output_db_instance_replica_backup_retention_period"></a> [db\_instance\_replica\_backup\_retention\_period](#output\_db\_instance\_replica\_backup\_retention\_period) | The backup window of the replica instance. |
| <a name="output_db_instance_replica_backup_window"></a> [db\_instance\_replica\_backup\_window](#output\_db\_instance\_replica\_backup\_window) | The backup retention period of the replica instance. |
| <a name="output_db_instance_replica_endpoint"></a> [db\_instance\_replica\_endpoint](#output\_db\_instance\_replica\_endpoint) | The connection endpoint of the replica instance. |
| <a name="output_db_instance_replica_engine_version_actual"></a> [db\_instance\_replica\_engine\_version\_actual](#output\_db\_instance\_replica\_engine\_version\_actual) | The running version of the replica instance. |
| <a name="output_db_instance_replica_identifier"></a> [db\_instance\_replica\_identifier](#output\_db\_instance\_replica\_identifier) | The replica instance identifier. |
| <a name="output_db_instance_replica_maintenance_window"></a> [db\_instance\_replica\_maintenance\_window](#output\_db\_instance\_replica\_maintenance\_window) | The maintenance window of the replica instance. |
| <a name="output_db_instance_replica_resource_id"></a> [db\_instance\_replica\_resource\_id](#output\_db\_instance\_replica\_resource\_id) | The Resource ID of the replica instance. |
| <a name="output_db_instance_replica_status"></a> [db\_instance\_replica\_status](#output\_db\_instance\_replica\_status) | The status of the replica instance. |
| <a name="output_db_instance_resource_id"></a> [db\_instance\_resource\_id](#output\_db\_instance\_resource\_id) | The Resource ID of the RDS instance. |
| <a name="output_db_instance_status"></a> [db\_instance\_status](#output\_db\_instance\_status) | The status of the RDS instance. |
| <a name="output_db_multi_replica_address"></a> [db\_multi\_replica\_address](#output\_db\_multi\_replica\_address) | The address of the replica instance (Simple mode). |
| <a name="output_db_multi_replica_arn"></a> [db\_multi\_replica\_arn](#output\_db\_multi\_replica\_arn) | The ARN of the replica instance (Simple mode). |
| <a name="output_db_multi_replica_availability_zone"></a> [db\_multi\_replica\_availability\_zone](#output\_db\_multi\_replica\_availability\_zone) | The availability zone of the replica instance (Simple mode). |
| <a name="output_db_multi_replica_backup_retention_period"></a> [db\_multi\_replica\_backup\_retention\_period](#output\_db\_multi\_replica\_backup\_retention\_period) | The backup window of the replica instance (Simple mode). |
| <a name="output_db_multi_replica_backup_window"></a> [db\_multi\_replica\_backup\_window](#output\_db\_multi\_replica\_backup\_window) | The backup retention period of the replica instance (Simple mode). |
| <a name="output_db_multi_replica_endpoint"></a> [db\_multi\_replica\_endpoint](#output\_db\_multi\_replica\_endpoint) | The connection endpoint of the replica instance (Simple mode). |
| <a name="output_db_multi_replica_engine_version_actual"></a> [db\_multi\_replica\_engine\_version\_actual](#output\_db\_multi\_replica\_engine\_version\_actual) | The running version of the replica instance (Simple mode). |
| <a name="output_db_multi_replica_identifier"></a> [db\_multi\_replica\_identifier](#output\_db\_multi\_replica\_identifier) | The replica instance identifier (Simple mode). |
| <a name="output_db_multi_replica_maintenance_window"></a> [db\_multi\_replica\_maintenance\_window](#output\_db\_multi\_replica\_maintenance\_window) | The maintenance window of the replica instance (Simple mode). |
| <a name="output_db_multi_replica_resource_id"></a> [db\_multi\_replica\_resource\_id](#output\_db\_multi\_replica\_resource\_id) | The Resource ID of the replica instance (Simple mode). |
| <a name="output_db_multi_replica_status"></a> [db\_multi\_replica\_status](#output\_db\_multi\_replica\_status) | The status of the replica instance (Simple mode). |
| <a name="output_parameter_group_id"></a> [parameter\_group\_id](#output\_parameter\_group\_id) | The ID of the DB parameter group. |
| <a name="output_subnet_group_id"></a> [subnet\_group\_id](#output\_subnet\_group\_id) | The ID of the DB subnet Group. |
<!-- END_TF_DOCS -->

## Examples of usage

Do you want to see how the module works? See all the [usage examples](examples).

## Related modules

The list of related modules (if present).

## Contributing

If you are interested in contributing to the project, see see our [guide](https://github.com/opsd-io/contribution).

## Support

If you have a problem with the module or want to propose a new feature, you can report it via the project's (Github) issue tracker.

If you want to discuss something in person, you can join our community on [Slack](https://join.slack.com/t/opsd-community/signup).

## License

[Apache License 2.0](LICENSE)
