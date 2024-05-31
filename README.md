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
| [aws_db_instance.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_instance.replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | A size of the DB storage. | `number` | `20` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Enables minor version auto upgrade. | `bool` | `false` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The availability zone of the instance. | `string` | `null` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for. | `number` | `1` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | The daily time range (in UTC) during which automated backups are created if they are enabled. | `string` | `"03:00-06:00"` | no |
| <a name="input_blue_green_update_enabled"></a> [blue\_green\_update\_enabled](#input\_blue\_green\_update\_enabled) | Enables low-downtime updates when true. | `bool` | `false` | no |
| <a name="input_ca_cert_identifier"></a> [ca\_cert\_identifier](#input\_ca\_cert\_identifier) | The identifier of the CA certificate for the DB instance. | `string` | `null` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | Copy all Instance tags to snapshots. | `bool` | `false` | no |
| <a name="input_create_db_parameter_group"></a> [create\_db\_parameter\_group](#input\_create\_db\_parameter\_group) | If true, a database parameter group is created. | `bool` | `false` | no |
| <a name="input_custom_iam_instance_profile"></a> [custom\_iam\_instance\_profile](#input\_custom\_iam\_instance\_profile) | The instance profile associated with the underlying Amazon EC2 instance of an RDS Custom DB instance. | `string` | `null` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The database name. | `string` | `"defaultdb"` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | The name of DB subnet group. | `string` | `null` | no |
| <a name="input_dedicated_log_volume"></a> [dedicated\_log\_volume](#input\_dedicated\_log\_volume) | Use a dedicated log volume (DLV) for the DB instance. | `bool` | `false` | no |
| <a name="input_delete_automated_backups"></a> [delete\_automated\_backups](#input\_delete\_automated\_backups) | Specifies whether to remove automated backups immediately after the DB instance is deleted. | `bool` | `true` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | The database can't be deleted when this value is set to true. | `bool` | `false` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | value | `set(string)` | `null` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version to use. | `string` | `"16.3"` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | he name of your final DB snapshot when this DB instance is deleted. | `string` | `null` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Enables mappings of AWS IAM accounts to database accounts. | `bool` | `false` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance type of the RDS instance. | `string` | `"db.t4g.micro"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The database instance identifier. | `string` | n/a | yes |
| <a name="input_iops"></a> [iops](#input\_iops) | The database storage type. | `number` | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key. | `string` | `null` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The window to perform maintenance in. | `string` | `"Mon:00:00-Mon:03:00"` | no |
| <a name="input_manage_master_user_password"></a> [manage\_master\_user\_password](#input\_manage\_master\_user\_password) | Set to true to allow RDS to manage the master user password in Secrets Manager. | `bool` | `null` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | The upper limit to which Amazon RDS can automatically scale the storage of the DB instance. | `number` | `0` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. | `number` | `0` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. | `string` | `null` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Specifies if the RDS instance is multi-AZ. | `bool` | `false` | no |
| <a name="input_network_type"></a> [network\_type](#input\_network\_type) | The network type of the DB instance. | `string` | `"IPV4"` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | The name of the database parameter group. | `string` | `null` | no |
| <a name="input_parameters_map"></a> [parameters\_map](#input\_parameters\_map) | A map of parameters included in the database parameter group. | `map(string)` | `{}` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for the master DB user. | `string` | `null` | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Specifies whether Performance Insights are enabled. | `bool` | `false` | no |
| <a name="input_performance_insights_kms_key_id"></a> [performance\_insights\_kms\_key\_id](#input\_performance\_insights\_kms\_key\_id) | The ARN for the KMS key to encrypt Performance Insights data. | `string` | `null` | no |
| <a name="input_performance_insights_retention_period"></a> [performance\_insights\_retention\_period](#input\_performance\_insights\_retention\_period) | Amount of time in days to retain Performance Insights data. | `number` | `0` | no |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections. | `number` | `5432` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Bool to control if instance is publicly accessible. | `bool` | `false` | no |
| <a name="input_replica_availability_zone"></a> [replica\_availability\_zone](#input\_replica\_availability\_zone) | The availability zone of the replica instance. | `string` | `null` | no |
| <a name="input_replica_enabled"></a> [replica\_enabled](#input\_replica\_enabled) | If true, the DB replica is created. | `bool` | `false` | no |
| <a name="input_replica_name"></a> [replica\_name](#input\_replica\_name) | The replica instance identifier. | `string` | `null` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB instance is deleted. | `bool` | `true` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this database from a snapshot. | `string` | `null` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | The storage throughput value for the DB instance. | `bool` | `false` | no |
| <a name="input_storage_throughput"></a> [storage\_throughput](#input\_storage\_throughput) | The storage throughput value for the DB instance. | `number` | `null` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | The database storage type. | `string` | `"gp3"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A set of subnet IDs used to create DB subnet group. | `set(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags. | `map(string)` | `{}` | no |
| <a name="input_username"></a> [username](#input\_username) | Username for the master DB user. | `string` | `"dbadmin"` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | The database storage type. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the RDS instance. |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The connection endpoint. |
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
