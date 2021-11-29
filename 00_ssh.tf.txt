resource "aws_key_pair" "ssw-key" {
  key_name = "ssw1-key"
  public_key = file("../../.ssh/sswkey.pub")  
}