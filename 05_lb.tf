resource "aws_lb" "ssw_alb" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ssw_sg.id]
  subnets            = [aws_subnet.ssw_pub[0].id, aws_subnet.ssw_pub[1].id]
  tags = {
    "Name" = "${var.name}-alb"
  }
}

output "dns_name" {
  value = aws_lb.ssw_alb.dns_name
}

resource "aws_lb_target_group" "ssw_albtg" {
  name     = "${var.name}-albtg"
  port     = var.port_http
  protocol = var.protocol
  vpc_id   = aws_vpc.ssw_vpc.id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 5
    matcher             = "200"
    path                = "/health.html"
    port                = "traffic-port"
    protocol            = var.protocol
    timeout             = 2
    unhealthy_threshold = 2
  }

}

resource "aws_lb_listener" "ssw_alblis" {
  load_balancer_arn = aws_lb.ssw_alb.arn
  port              = var.port_http
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ssw_albtg.arn
  }
}

resource "aws_lb_target_group_attachment" "ssw_albtgatt" {
  target_group_arn = aws_lb_target_group.ssw_albtg.arn
  target_id        = aws_instance.ssw_web.id
  port             = var.port_http

}
