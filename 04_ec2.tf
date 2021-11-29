resource "aws_security_group" "ssw_sg" {
  name        = "${var.name}-sg"
  description = "HTTP_ICMP_SQL"
  vpc_id      = aws_vpc.ssw_vpc.id

  ingress = [
    {
      description      = var.ssh
      from_port        = var.port_ssh
      to_port          = var.port_ssh
      protocol         = var.pro_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_routev6]
      prefix_list_ids  = var.nul
      security_groups  = var.nul
      self             = var.nul
    },
    {
      description      = var.http
      from_port        = var.port_http
      to_port          = var.port_http
      protocol         = var.pro_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_routev6]
      prefix_list_ids  = var.nul
      security_groups  = var.nul
      self             = var.nul
    },
    {
      description      = var.icmp
      from_port        = var.minus
      to_port          = var.minus
      protocol         = var.pro_icmp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_routev6]
      prefix_list_ids  = var.nul
      security_groups  = var.nul
      self             = var.nul
    },
    {
      description      = var.mysql
      from_port        = var.Port_mysql
      to_port          = var.Port_mysql
      protocol         = var.pro_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_routev6]
      prefix_list_ids  = var.nul
      security_groups  = var.nul
      self             = var.nul
    },
  ]

  egress = [
    {
      description      = "all"
      from_port        = var.port_zero
      to_port          = var.port_zero
      protocol         = "-1" # 지정하지 않겠다
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.cidr_routev6]
      prefix_list_ids  = var.nul
      security_groups  = var.nul
      self             = var.nul
    }
  ]
  tags = {
    "Name" = "{var.name}-websg"
  }
}

data "aws_ami" "amzn" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
} #aws ami 가져오는 명령어

resource "aws_instance" "ssw_web" {
  ami                    = data.aws_ami.amzn.id
  instance_type          = "t2.micro"
  key_name               = var.key
  vpc_security_group_ids = [aws_security_group.ssw_sg.id]
  availability_zone      = "${var.region}${var.ava_zone[0]}"
  private_ip             = "10.0.0.11" #하도 오류가 많이 나서 일단 주석처리 -> 근데 본인 마음대로 하면 됨
  subnet_id              = aws_subnet.ssw_pub[0].id
  user_data              = file("./install.sh")
  tags = {
    "Name" = "${var.name}-web"
  }
}

resource "aws_eip" "ssw_web_ip" {
  vpc                       = true
  instance                  = aws_instance.ssw_web.id
  associate_with_private_ip = "10.0.0.11" #위의 Private ip가 주석처리 되었으므로 얘도 주석처리
  depends_on                = [aws_internet_gateway.ssw_ig]
}

output "public_ip" {
  value = aws_instance.ssw_web.public_ip
}
