resource "aws_subnet" "public_subnet" {
  for_each = local.subnets.public

  vpc_id                  = aws_vpc.tc_vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name  = each.key
    Scope = "public"
  }

  depends_on = [aws_vpc.tc_vpc]
}

resource "aws_subnet" "private_subnet" {
  for_each = local.subnets.private

  vpc_id            = aws_vpc.tc_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name  = each.key
    Scope = "private"
  }

  depends_on = [aws_vpc.tc_vpc]
}

resource "aws_subnet" "database_subnet" {
  count = length(local.subnets.database)

  vpc_id            = aws_vpc.tc_vpc.id
  cidr_block        = element(local.subnets.database.*.cidr_block, count.index)
  availability_zone = element(local.subnets.database.*.availability_zone, count.index)

  tags = {
    Name  = "Database Subnet ${count.index}"
    Scope = "database"
  }

  depends_on = [aws_vpc.tc_vpc]
}

