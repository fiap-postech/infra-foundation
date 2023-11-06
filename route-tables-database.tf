# Create public route table
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.tc_vpc.id

  tags = {
    Name = "Database Route Table"
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_route" "database_igw_route" {
  route_table_id         = aws_route_table.database.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id

  depends_on = [
    aws_route_table.database,
    aws_internet_gateway.internet_gateway
  ]
}

resource "aws_route_table_association" "database_subnet" {
  count = length(aws_subnet.database_subnet)

  subnet_id      = element(aws_subnet.database_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id

  depends_on = [
    aws_route_table.public,
    aws_vpc.tc_vpc,
    aws_subnet.database_subnet,
  ]
}