resource "aws_eip" "ssw_ngw_ip" {
  vpc = true
}

resource "aws_nat_gateway" "ssw_ngw" {
  allocation_id = aws_eip.ssw_ngw_ip.id
  subnet_id     = aws_subnet.ssw_pub[0].id
  tags = {
    "Name" = "${var.name}-ngw"
  }
}

resource "aws_route_table" "ssw_ngwrt" {
  vpc_id = aws_vpc.ssw_vpc.id

  route {
    cidr_block = var.cidr_route
    gateway_id = aws_nat_gateway.ssw_ngw.id
  }
  tags = {
    "Name" = "${var.name}-ngwrt"
  }
}

resource "aws_route_table_association" "ssw_ngwass_pri" {
  count          = length(var.pri_sub)
  subnet_id      = aws_subnet.ssw_pri[count.index].id
  route_table_id = aws_route_table.ssw_ngwrt.id
}

resource "aws_route_table_association" "ssw_ngwass_pridba" {
  count          = length(var.pri_subdb)
  subnet_id      = aws_subnet.ssw_pridb[count.index].id
  route_table_id = aws_route_table.ssw_ngwrt.id
}
