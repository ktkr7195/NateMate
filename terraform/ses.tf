resource "aws_ses_domain_identity" "natemate-ses" {
  provider = aws.south
  domain   = aws_route53_zone.natemate.name
}
