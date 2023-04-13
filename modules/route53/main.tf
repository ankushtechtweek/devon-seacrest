#route53

data "aws_route53_zone" "route53_zone" {
name         = "${var.acm.domain_name}"
private_zone = false
}

resource "aws_route53_record" "acm" {
  allow_overwrite = true
  zone_id = data.aws_route53_zone.route53_zone.zone_id 
  name    = "${var.acm_record_name}"
  type    = "${var.acm_record_type}"
  records = ["${var.acm_record_value}"]
  ttl     = "60"

}


resource "aws_route53_record" "alb" {
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  name    = "testing.techtweekinfotech.com"
  type    = "CNAME"
  ttl     = 300
  records = [
        "${var.alb_dns}",
      ]
}
