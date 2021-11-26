resource "aws_lb" "ssw_alb" {
    name = "ssw-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.ssw_sg.id]
    subnets = [aws_subnet.ssw_puba.id,aws_subnet.ssw_pubc.id]
    tags = {
      "Name" = "ssw-alb"
    }
}