resource "aws_acm_certificate" "natemate-certificate" {
  domain_name = aws_route53_zone.natemate.name

  tags = {
    "natemate" = "website"
  }
}
