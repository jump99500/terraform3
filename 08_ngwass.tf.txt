resource "aws_route_table_association" "ssw_ngwass_pria" {
  subnet_id = aws_subnet.ssw_pria.id
  route_table_id = aws_route_table.ssw_ngwrt.id
}

resource "aws_route_table_association" "ssw_ngwass_pric" {
  subnet_id = aws_subnet.ssw_pric.id
  route_table_id = aws_route_table.ssw_ngwrt.id
}

resource "aws_route_table_association" "ssw_ngwass_pridba" {
  subnet_id = aws_subnet.ssw_pridba.id
  route_table_id = aws_route_table.ssw_ngwrt.id
}

resource "aws_route_table_association" "ssw_ngwass_pridbc" {
  subnet_id = aws_subnet.ssw_pridbc.id
  route_table_id = aws_route_table.ssw_ngwrt.id
}