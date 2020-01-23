resource "aws_lb" "natemate-lb" {
  name               = "natemateLB"
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.instance-group.id
  ]

  subnets = [
    aws_subnet.natemate-subnet.id,
    aws_subnet.private-subnet-2.id
  ]
}

resource "aws_lb_target_group" "natemate-http" {
  name     = "natemateGP"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.natemate-vpc.id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/helth.html"
    port                = 80
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "natemate-https" {
  load_balancer_arn = aws_lb.natemate-lb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.natemate-certificate.arn

  default_action {
    target_group_arn = aws_lb_target_group.natemate-http.arn
    type             = "forward"

  }
}


