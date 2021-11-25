#가용 영역 a의 public subnet
resource "aws_subnet" "ssw_puba" {
  vpc_id            = aws_vpc.ssw_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    "Name" = "ssw-puba"
  }
}

resource "aws_subnet" "ssw_pubc" {
  vpc_id            = aws_vpc.ssw_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-2c"
  tags = {
    "Name" = "ssw-pubc"
  }
}

resource "aws_subnet" "ssw_pria" {
  vpc_id            = aws_vpc.ssw_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    "Name" = "ssw-pria"
  }
}

resource "aws_subnet" "ssw_pric" {
  vpc_id            = aws_vpc.ssw_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-2c"
  tags = {
    "Name" = "ssw-pric"
  }
}

resource "aws_subnet" "ssw_pridba" {
  vpc_id            = aws_vpc.ssw_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    "Name" = "ssw-pridba"
  }
}

resource "aws_subnet" "ssw_pridbc" {
  vpc_id            = aws_vpc.ssw_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "ap-norheast-2c"
  tags = {
    "Name" = "ssw-pridbc"
  }
}
