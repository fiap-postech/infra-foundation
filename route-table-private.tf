resource "aws_route_table" "private" {
  count  = 3
  vpc_id = aws_vpc.tc_vpc.id

  tags = {
    Name = "Private Route Table ${count.index}"
  }

  depends_on = [
    aws_vpc.tc_vpc
  ]
}

resource "aws_route" "nat_gateway" {
  count                  = 3
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id

  depends_on = [aws_nat_gateway.nat, aws_route_table.private]
}

resource "aws_route_table_association" "private" {
  count          = 3
  subnet_id      = element(values(aws_subnet.private_subnet), count.index).id
  route_table_id = element(aws_route_table.private.*.id, count.index)
}