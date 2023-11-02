resource "aws_vpc" "tc_vpc" {
  cidr_block           = local.vpc.cidr_block
  enable_dns_hostnames = local.vpc.enable_dns_hostnames
  tags = {
    Name = local.vpc.name
  }
}