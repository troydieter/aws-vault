

variable "aws-profile" {
  description = "AWS profile for provisioning the resources"
  type = "string"
}

variable "aws_region" {
  description = "AWS Region"
  default = "us-east-1"
  type = "string"
}


variable "ami-id" {
  description = "AMI-Id for spinning up the Ec2-instances"
  type = "string"
}

variable "key_name" {
  description = "Private key name that has to be associated to the EC2 instances"
  type = "string"
}

variable "hcvault-ec2-instance-type" {
  description = "HCVault Instance Type"
  type = "string"
}


variable "hcvault-ec2-root-volume-size" {
description = "EBS Volume size"
default = "35"
type = "string"
}

variable "hcvault-ec2-ebs-volume-size" {
  description = "EBS Volume size"
  default = "35"
  type = "string"
}

# variable "hcvault-ec2-instance-profile" {
#  description = "IAM Role attached"
#  type = "string"
# }

variable "environment" {
  description = "HCVault environment"
  type  = "string"
}


