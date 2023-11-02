# Configure route tables
resource "aws_default_route_table" "private_route_table" {
  default_route_table_id = aws_vpc.tc_vpc.default_route_table_id
  tags = {
    Name = "Private Route Table"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    # nat_gateway_id = aws_eip.nat.id
  }

  depends_on = [
    aws_vpc.tc_vpc,
    # aws_eip.nat,
  ]
}

# Associate private route table with private subnets
resource "aws_route_table_association" "private_subnet" {
  for_each = aws_subnet.private_subnet

  subnet_id      = each.value.id
  route_table_id = aws_vpc.tc_vpc.default_route_table_id

  depends_on = [
    aws_default_route_table.private_route_table,
    aws_vpc.tc_vpc,
    aws_subnet.private_subnet,
  ]
}

# Create public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.tc_vpc.id
  tags = {
    Name = "Public Route Table"
  }
}

# Associate public route table with public subnets
resource "aws_route_table_association" "public_subnet" {
  for_each = aws_subnet.public_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id

  depends_on = [
    aws_default_route_table.private_route_table,
    aws_vpc.tc_vpc,
    aws_subnet.public_subnet,
  ]
}
