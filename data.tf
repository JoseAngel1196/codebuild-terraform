data "aws_caller_identity" "current" {}

data "aws_ecr_repository" "ecr" {
  name = "${var.environment}-${var.service_name}"
}