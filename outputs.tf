output "arn" {
  description = "The ARN of the RDS instance."
  value       = aws_db_instance.main.arn
}

output "endpoint" {
  description = "The connection endpoint."
  value       = aws_db_instance.main.endpoint
}
