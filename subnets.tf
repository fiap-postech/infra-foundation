resource "aws_subnet" "public_subnet" {
  for_each = local.subnets.public

  vpc_id            = aws_vpc.tc_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.key
  }

  depends_on = [aws_vpc.tc_vpc]
}

resource "aws_subnet" "private_subnet" {
  for_each = local.subnets.private

  vpc_id            = aws_vpc.tc_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.key
  }

  depends_on = [aws_vpc.tc_vpc]
}

