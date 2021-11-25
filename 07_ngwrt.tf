resource "aws_route_table" "ssw_ngwrt" {
  vpc_id = aws_vpc.ssw_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ssw_ngw.id
  }
  tags = {
    "Name" = "ssw-ngwrt"
  }
}

