resource "aws_ami_from_instance" "ssw_ami" {
  name               = "${var.name}-ami"
  source_instance_id = aws_instance.ssw_web.id
  depends_on = [
    aws_instance.ssw_web
  ]
}

resource "aws_launch_configuration" "ssw_lacf" {
  name                 = "${var.name}-lacf"
  image_id             = aws_ami_from_instance.ssw_ami.id
  instance_type        = "t2.micro"
  iam_instance_profile = "ssw_role" #IAM 역할 만든거
  security_groups      = [aws_security_group.ssw_sg.id]
  key_name             = var.key
  user_data            = <<-EOF
                #!/bin/bash
                systemctl start httpd
                systemctl enable httpd
                EOF
}

resource "aws_placement_group" "ssw_pg" {
    name = "${var.name}-pg"
    strategy = "cluster"  
}

resource "aws_autoscaling_group" "ssw_atsg" {
    name = "${var.name}-atsg"
    min_size = 2
    max_size = 10
    health_check_grace_period = 60
    health_check_type = "EC2"
    desired_capacity = 2
    force_delete = false
    launch_configuration = aws_launch_configuration.ssw_lacf.name
    #placement_group = aws_placement_group.ssw_pg.id
    vpc_zone_identifier = [aws_subnet.ssw_pub[0].id,aws_subnet.ssw_pub[1].id]
    }

    resource "aws_autoscaling_attachment" "ssw_asatt" {
    autoscaling_group_name = aws_autoscaling_group.ssw_atsg.id
    alb_target_group_arn = aws_lb_target_group.ssw_albtg.arn
    }

