module "example" {
  source = "github.com/opsd-io/terraform-module-aws-rds-postgres"

  instance_name  = "example"
  engine_version = "16.3"
  instance_class = "db.t4g.micro"

  username = "dbadmin"
  password = "avoid-plaintext-passwords"

  max_allocated_storage = 30

  common_tags = {
    "Env"  = "test"
  }

}
