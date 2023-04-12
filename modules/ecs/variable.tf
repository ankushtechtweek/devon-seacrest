variable "environment" {
  description = "project environment"
  type        = string
}

variable "name" {
  description = "project name"
  type        = string
}

variable "region" {
  description = "project region"
  type        = string
}

variable "vpc" {
  description = "vpc"
  type        = any
}

variable "public_subnets" {
  description = "vpc subnets"
  type        = any
}

variable "vpc_id" {
  description = "vpc id"
  type        = any
}

variable "ecr_repo_url" {
  description = "repo url of api ecr"
  type        = any
}

variable "ecs_task_def" {
  description = "task def of api ecs"
  type        = any
}

variable "tg_arn" {

  description  = "ALB target group arn"
  type    = any
}


variable "retention_in_days" {
  description  = "retention period for cloudwatch"
  type    = any
}
