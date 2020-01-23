resource "aws_security_group" "instance-group" {

  description = "SHH"
  name        = "NateMate-SecurityGroup"
  vpc_id      = aws_vpc.natemate-vpc.id

}

resource "aws_security_group" "natemate-rds" {

  description = "RDS security group for NateMate"
  name        = "NateMate_RDS"
  vpc_id      = aws_vpc.natemate-vpc.id
}