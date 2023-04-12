variable "environment" {
  description = "project environment"
  type        = string
}

variable "name" {
  description = "project name"
  type        = string
}



variable "region" {
  description = "project aws region"
  type        = string
}


variable "ec2-instance" {
  description = "ec2 instance"
  type        = any
}


variable "ecr" {
  description = "ecr repo"
  type        = any
}
#VPC



# ALB
variable "alb" {
  description = "ALB"
  type        = any
}

variable "account_id" {
  description = "account id"
  type        = any
}

variable "rds" {
  description = "rds"
  type        = any
}

variable "cloud" {
  description = "cloud"
  type        = any

}
variable "vpc" {
  description = "vpc"
  type        = any
  }


variable "github" {
  description = "github"
  type        = any
}


variable "elastic_cache" {
  description = "elastic cache"
  type        = any
}

#ECS

variable "retention_in_days" {
  description  = "retention period for cloudwatch"
  type    = any
}

variable "ecs_task_def" {
  description = "task def of api ecs"
  type        = any
}

#amplify

variable "amplify" {
  description = "amplify"
  type        = any
}

variable "NEXT_PUBLIC_API_DOMAIN" {
  description = "amplify env"
  type        = string
  default     = ""
}

variable "NEXT_PUBLIC_CODAT_LINK" {
  description = "amplify env"
  type        = string
  default     = ""
}

variable "acm" {
  description = "acm"
  type        = any
}

variable "s3_name" {
  description = "s3_name"
  type        = any
}
