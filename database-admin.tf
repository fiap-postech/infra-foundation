resource "aws_secretsmanager_secret" "database_admin_secret" {
  name                    = local.database_admin_secret_name
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "database_admin_version" {
  secret_id     = aws_secretsmanager_secret.database_admin_secret.id
  secret_string = var.database_admin_password
}