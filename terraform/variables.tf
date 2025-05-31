variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_a" {
  default = "10.0.1.0/24"
}

variable "public_subnet_cidr_b" {
  default = "10.0.2.0/24"
}
