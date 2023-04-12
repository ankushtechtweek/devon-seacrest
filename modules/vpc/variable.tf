variable "environment" {
  description = "project environment"
  type        = string
}

variable "name" {
  description = "project name"
  type        = string
}

variable "vpc" {
  description = "vpc"
  type        = any
}

variable "account_id" {
  description = "account id"
  type        = any
}

variable "region" {
  description = "project aws region"
  type        = string
}
