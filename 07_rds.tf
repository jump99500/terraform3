resource "aws_db_instance" "ssw_mydb" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t2.micro"
  name                   = "mydb"
  identifier             = "mydb"
  username               = "admin"
  password               = "12341234"
  parameter_group_name   = "default.mysql8.0"
  availability_zone      = "${var.region}${var.ava_zone[0]}"
  db_subnet_group_name   = aws_db_subnet_group.ssw_dbsg.id
  vpc_security_group_ids = [aws_security_group.ssw_sg.id]
  skip_final_snapshot    = true
  tags = {
    "Name" = "${var.name}-db"
  }
}
resource "aws_db_subnet_group" "ssw_dbsg" {
  name       = "${var.name}-dbsg"
  subnet_ids = [aws_subnet.ssw_pridb[0].id, aws_subnet.ssw_pridb[1].id]
}

