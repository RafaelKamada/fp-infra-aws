variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "lab_role_arn" {
  type    = string
  default = "arn:aws:iam::618817506326:role/LabRole"
}

variable "project_name" {
  type    = string
  default = "foodorder"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "ecs_desired_count" {
  type    = number
  default = 1
}
