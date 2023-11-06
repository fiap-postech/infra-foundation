# resource "aws_eip" "nat" {
#   vpc = true
# }

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.tc_vpc.id

  tags = {
    Name = "Internet Gateway"
  }

  depends_on = [aws_vpc.tc_vpc]
}

resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.internet_gateway]
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(values(aws_subnet.public_subnet), 0).id

  depends_on = [
    aws_internet_gateway.internet_gateway,
    aws_eip.nat_eip,
    aws_subnet.public_subnet
  ]
}
