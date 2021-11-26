resource "aws_ami_from_instance" "ssw_ami" {
    name = "ssw-ami"
    source_instance_id = aws_instance.ssw_web.id
    depends_on = [
        aws_instance.ssw_web
    ]
}