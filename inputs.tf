variable "aws_region" {
  type = string
  default = "eu-west-3"
}

variable "aws_profile" {
  type = string
  default = ""
}

variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "domain_name" {
  type = string
}

variable "certbot_email" {
  type = string
}