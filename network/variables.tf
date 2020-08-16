

variable "aws_account" {
  description = "AWS Account Name"
  type  = string
}
variable "environment" {
  description = "AWS Environment"
  type  = string
}



variable "vpc_cidr" {
  description = "VPC CIDR"
  type  = string
}


variable "private_subnet_cidrs" {
description = "Private subnet  - CIDR"
type  = list
}
variable "public_subnet_cidrs" {
description = "Private subnet  - CIDR"
type  = list
}


variable "aws-profile" {
  description = "Local AWS Profile Name "
  type  = string
}
variable "aws_region" {
  description = "aws region"
  default="us-east-1"
  type  = string
}
