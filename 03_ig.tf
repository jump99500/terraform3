resource "aws_internet_gateway" "ssw_ig" {
    vpc_id = aws_vpc.ssw_vpc.id

    tags = {
      "Name" = "ssw-ig"
    }
}   