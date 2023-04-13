output "route53_fqdn" {
  value = aws_route53_record.acm.fqdn
}