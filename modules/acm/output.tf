output "acm_arn" {
  value = aws_acm_certificate.ssl.arn
}

output "acm_record_name" {
  value = tolist(aws_acm_certificate.ssl.domain_validation_options)[0].resource_record_name
}

output "acm_record_type" {
  value = tolist(aws_acm_certificate.ssl.domain_validation_options)[0].resource_record_type
}

output "acm_record_value" {
  value = tolist(aws_acm_certificate.ssl.domain_validation_options)[0].resource_record_value
}
