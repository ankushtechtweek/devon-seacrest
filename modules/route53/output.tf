output "route53_fqdn" {
  value = aws_route53_record.acm.fqdn
}

output "cdn_route53_fqdn" {
  value = aws_route53_record.cdn_acm.fqdn
}

