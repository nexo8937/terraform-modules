output "rds_endpoint" {
  value = aws_db_instance.db.endpoint
}
output "rds-access" {
  value = aws_security_group.rds.id
}

#output "rds-access" {
#  value = aws_security_group.rds-access.id
#}
