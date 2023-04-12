resource "aws_acm_certificate" "ssl" {
  domain_name = "${var.acm.domain_name}"
  subject_alternative_names = ["*.${var.acm.domain_name}"]
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "ssl" {
  certificate_arn = "${aws_acm_certificate.ssl.arn}"
  validation_record_fqdns = [
    "${var.route53_fqdn}",
  ]
}
