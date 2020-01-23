resource "aws_instance" "natemate-ec2" {
  ami                     = "ami-068a6cefc24c301d2"
  instance_type           = "t2.micro"
  key_name                = var.aws_instance_key_name
  vpc_security_group_ids  = [aws_security_group.instance-group.id]
  subnet_id               = aws_subnet.natemate-subnet.id
  disable_api_termination = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
  }

  tags = {
    Name                 = "natemate_ec2"
    "natemate-instance2" = ""
  }
}

variable "aws_instance_key_name" {}