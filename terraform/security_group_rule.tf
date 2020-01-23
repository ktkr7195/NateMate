
resource "aws_security_group_rule" "instance-group" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0",
  "0.0.0.0/16"]
  security_group_id = aws_security_group.instance-group.id
}
resource "aws_security_group_rule" "instance-group-1" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.instance-group.id
}

resource "aws_security_group_rule" "instance-group-2" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.instance-group.id
}

resource "aws_security_group_rule" "instance-group-3" {
  type      = "ingress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0",
  "0.0.0.0/16"]
  security_group_id = aws_security_group.instance-group.id
}

resource "aws_security_group_rule" "instance-group-4" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.instance-group.id
}

resource "aws_security_group_rule" "instance-group-5" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.instance-group.id
}

#for RDS security-group-rule

resource "aws_security_group_rule" "natemate-rds" {
  description       = "NateMate RDS"
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.natemate-rds.id
}

resource "aws_security_group_rule" "natemate-rds-1" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.natemate-rds.id
}

resource "aws_security_group_rule" "natemate-rds-2" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.natemate-rds.id
}




