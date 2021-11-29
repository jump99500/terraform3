provider "aws" {
  region = var.region
}

resource "aws_key_pair" "ssw-key" {
  key_name   = var.key #변수로 참조
  public_key = file("../../.ssh/sswkey.pub")
}

resource "aws_vpc" "ssw_vpc" {
  cidr_block           = var.cidr_main
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "${var.name}-vpc" #문자열 안에서는 ${}로 보강구문을 만들어 사용
  }
}

#가용 영역 a의 public subnet
resource "aws_subnet" "ssw_pub" {
  count             = length(var.pub_sub)                         #2를 쓰지 않고 length로 변수를 줄 수도 있음:var.pub_sub에 길이 = 2 이기 때문에 값이 똑같음
  vpc_id            = aws_vpc.ssw_vpc.id                          #index 0 -> 10.0.0.0/24
  cidr_block        = var.pub_sub[count.index]                    #count 1 -> 10.0.0.0.24
  availability_zone = "${var.region}${var.ava_zone[count.index]}" #index 값이 0이면 a
  tags = {
    "Name" = "${var.name}-pub${var.ava_zone[count.index]}"
  }
}

resource "aws_subnet" "ssw_pri" {
  count             = length(var.pri_sub)
  vpc_id            = aws_vpc.ssw_vpc.id
  cidr_block        = var.pri_sub[count.index]
  availability_zone = "${var.region}${var.ava_zone[count.index]}"
  tags = {
    "Name" = "${var.name}-pri${var.ava_zone[count.index]}"
  }
}

resource "aws_subnet" "ssw_pridb" {
  count             = length(var.pri_subdb) #2
  vpc_id            = aws_vpc.ssw_vpc.id
  cidr_block        = var.pri_subdb[count.index]
  availability_zone = "${var.region}${var.ava_zone[count.index]}"
  tags = {
    "Name" = "${var.name}-pridb${var.ava_zone[count.index]}"
  }
}
