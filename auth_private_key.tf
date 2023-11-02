resource "tls_private_key" "auth_key" {
  algorithm = local.private_key.auth.algorithm
  rsa_bits  = local.private_key.auth.size
}

resource "aws_key_pair" "auth_key_pair" {
  key_name   = local.private_key.auth.name
  public_key = tls_private_key.auth_key.public_key_openssh
}

resource "aws_secretsmanager_secret" "auth_signer_secret" {
  name = local.private_key.auth.signer_secret_name
}

resource "aws_secretsmanager_secret_version" "signer_version" {
  secret_id     = aws_secretsmanager_secret.auth_signer_secret.id
  secret_string = <<EOF
   {
    "key": "${tls_private_key.auth_key.private_key_pem}",
    "algorithm": "${local.private_key.auth.algorithm}",
    "size": "${local.private_key.auth.size}"
   }
EOF
}

resource "aws_secretsmanager_secret" "auth_verifier_secret" {
  name = local.private_key.auth.verifier_secret_name
}

resource "aws_secretsmanager_secret_version" "verifier_version" {
  secret_id     = aws_secretsmanager_secret.auth_verifier_secret.id
  secret_string = <<EOF
   {
    "key": "${tls_private_key.auth_key.public_key_pem}",
    "algorithm": "${local.private_key.auth.algorithm}",
    "size": "${local.private_key.auth.size}"
   }
EOF
}