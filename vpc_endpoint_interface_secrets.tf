resource "aws_security_group" "vpc_endpoints_ecr_secret_logs" {
  name        = "vpc-endpoints-secretsmanager-cloudwatchlogs-sg"
  description = "VPC endponts must accept requests from ECS"
  vpc_id      = aws_vpc.tc_vpc.id

  tags = {
    Name = "sg-vpc-endpoints-secretsmanager-cloudwatchlogs"
  }

  depends_on = [aws_vpc.tc_vpc]
}

resource "aws_vpc_endpoint" "secrets_manager_vpc_endpoint" {
  vpc_id              = aws_vpc.tc_vpc.id
  service_name        = "com.amazonaws.us-east-1.secretsmanager"
  subnet_ids          = [for s in aws_subnet.private_subnet : s.id]
  security_group_ids  = [aws_security_group.vpc_endpoints_ecr_secret_logs.id]
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true


  policy = <<POLICY
{
    "Statement": [
        {
            "Principal": "*",
            "Action": "secretsmanager:*",
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
POLICY



  depends_on = [
    aws_vpc.tc_vpc,
    aws_security_group.vpc_endpoints_ecr_secret_logs,
    aws_subnet.private_subnet
  ]
}