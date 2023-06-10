variable "service_name" {
  default = "helloworld-demo-node"
}

variable "environment" {
  default = "staging"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "secret_key" {
  type = string
}

variable "access_key" {
  type = string
}
