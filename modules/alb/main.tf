locals {
name_alb  = format("%s-%s-%s", var.name, var.environment, "alb")
name_tg   = format("%s-%s-%s", var.name, var.environment, "tg")
}

# Security group 

resource "aws_security_group" "security-group" {

  name        = "${local.name_alb}-sg"
  description = "SG for ALB"
  vpc_id      = var.vpc_id
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

   tags = {
   Name = "${local.name_alb}-sg"
}
}

##alb##

resource "aws_alb" "load-balancer" {
  name               = local.name_alb
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [aws_security_group.security-group.id]
     
  tags = {
   Name = local.name_alb
}
  }

##target group##

resource "aws_lb_target_group" "target-group" {

  name = "${local.name_alb}-tg-gp"

  port        = var.alb.port
  protocol    = var.alb.protocol
  vpc_id      = var.vpc_id
  target_type = var.alb.target_type

  health_check {
    path     = var.alb.path
    matcher  = var.alb.matcher 
    enabled  = var.alb.enabled 
    timeout  = var.alb.timeout 
    interval = var.alb.interval
    port     = var.alb.port
    protocol = var.alb.protocol
  }

  tags  = {
      Name = local.name_tg
  }
}

##listeners##

resource "aws_lb_listener" "listner-http" {
  load_balancer_arn = aws_alb.load-balancer.arn

  port     = "80"
  protocol = "HTTP"

  default_action {
    type = "redirect"

  redirect { 
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      }
  #listener_arn = aws_lb_listener.listner-https.arn
 }
}

resource "aws_lb_listener" "listner-https" {
  load_balancer_arn = aws_alb.load-balancer.arn

  port               = "443"
  protocol           = "HTTPS"
  certificate_arn    = var.certificate_arn

 default_action {
  type = "forward"
  target_group_arn = aws_lb_target_group.target-group.arn
 }
}

