resource "aws_eip" "ssw_ngw_ip" {
  vpc = true
}

resource "aws_nat_gateway" "ssw_ngw" {
  allocation_id = aws_internet_gateway.ssw_ig.id
  subnet_id     = aws_subnet.ssw_pria.id
  tags = {
    "Name" = "ssw-ngw"
  }
}
