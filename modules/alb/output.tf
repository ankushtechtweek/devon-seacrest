output "alb_name" {
  value = aws_alb.load-balancer.name
}

output "alb_arn" {
  value = aws_alb.load-balancer.arn
}

output "alb_dns" {
  value = aws_alb.load-balancer.dns_name
}

output "tg_arn" {
 
 value = aws_lb_target_group.target-group.arn
}
