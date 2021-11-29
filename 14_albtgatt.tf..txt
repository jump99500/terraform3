resource "aws_lb_target_group_attachment" "ssw_albtgatt" {
  target_group_arn = aws_lb_target_group.ssw_albtg.arn
  target_id        = aws_instance.ssw_web.id
  port             = 80

}
