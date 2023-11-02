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