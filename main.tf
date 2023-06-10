resource "aws_codebuild_project" "codebuild_project" {
  name        = "${var.environment}-${var.service_name}-codebuild-project"
  description = ""

  service_role = aws_iam_role.codebuild.arn

  source {
    # https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html#:~:text=The%20buildspec%20has%20the%20following%20syntax%3A
    buildspec = file("${path.module}/spec.yml")
    type      = "NO_SOURCE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    # https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
    image                       = "aws/codebuild/standard:5.0"
    image_pull_credentials_type = "CODEBUILD"
    type                        = "LINUX_CONTAINER"

    environment_variable {
      name  = "ENVIRONMENT"
      value = var.environment
    }

    environment_variable {
      name  = "SERVICE_NAME"
      value = var.service_name
    }
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  logs_config {
    cloudwatch_logs {
      group_name = "${var.environment}-${var.service_name}-codebuild-group"
    }
  }
}
