resource "aws_route_table" "ssw_rt" {
    vpc_id = aws_vpc.ssw_vpc.id
    
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.ssw_ig.id        
    }
    tags = {
      "Name" = "ssw-rt"
    }
}