resource "aws_route_table_association" "ssw_igas_puba" {
    subnet_id = aws_subnet.ssw_puba.id
    route_table_id = aws_route_table.ssw_rt.id
}

resource "aws_route_table_association" "ssw_igas_pubc" {
    subnet_id = aws_subnet.ssw_pubc.id
    route_table_id = aws_route_table.ssw_rt.id
}