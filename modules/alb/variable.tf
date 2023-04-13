variable "environment" {
  description = "project environment"
  type        = string
}

variable "name" {
  description = "project name"
  type        = string
}

# ALB
variable "alb" {
  description = "ALB"
  type        = any
}

variable "vpc_id" {
  description = "VPC id"
  type        = any
}

variable "public_subnets" {
  description = "Public Subnets"
  type        = any
}

variable "certificate_arn" {
  description = "certificate arn"
  type        = any
}

