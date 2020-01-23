resource "aws_route53_zone" "natemate" {
  name    = "natemate.com"
  comment = "natemate"
}

resource "aws_route53_record" "natemate-route53-record" {
  zone_id = aws_route53_zone.natemate.zone_id
  name    = aws_route53_zone.natemate.name
  type    = "A"

  alias {
    name                   = aws_lb.natemate-lb.dns_name
    zone_id                = aws_lb.natemate-lb.zone_id
    evaluate_target_health = false
  }

}



