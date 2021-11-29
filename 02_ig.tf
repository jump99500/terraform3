resource "aws_internet_gateway" "ssw_ig" {
    vpc_id = aws_vpc.ssw_vpc.id

    tags = {
      "Name" = "${var.name}-ig"
    }
}   

resource "aws_route_table" "ssw_rt" {
    vpc_id = aws_vpc.ssw_vpc.id
    
    route {
      cidr_block = var.cidr_route
      gateway_id = aws_internet_gateway.ssw_ig.id        
    }
    tags = {
      "Name" = "${var.name}-rt"
    }
}

resource "aws_route_table_association" "ssw_igass_pub" {
    count = 2
    subnet_id = aws_subnet.ssw_pub[count.index].id
    route_table_id = aws_route_table.ssw_rt.id
}