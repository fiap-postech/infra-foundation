# Create public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.tc_vpc.id

  tags = {
    Name = "Public Route Table"
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_route" "public_igw_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id

  depends_on = [
    aws_route_table.public,
    aws_internet_gateway.internet_gateway
  ]
}

resource "aws_route_table_association" "public_subnet" {
  for_each = aws_subnet.public_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id

  depends_on = [
    aws_route_table.public,
    aws_vpc.tc_vpc,
    aws_subnet.public_subnet,
  ]
}