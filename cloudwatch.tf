resource "aws_cloudwatch_event_rule" "rule" {
  name        = "${var.environment}-${var.service_name}-rule"
  description = "Trigger AWS CodeBuild to rollout the last ECR image of ${var.service_name} to AWS EKS."
  event_pattern = jsonencode(
    {
      "source" : ["aws.ecr"],
      "detail-type" : ["ECR Image Action"],
      "detail" : {
        "action-type" : ["PUSH"],
        "result" : ["SUCCESS"],
        "repository-name" : ["${var.environment}-${var.service_name}"]
      }
    }
  )
}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
  rule      = aws_cloudwatch_event_rule.rule.name
  target_id = "${var.environment}-codebuild-target"
  arn       = aws_codebuild_project.codebuild_project.arn
  role_arn  = aws_iam_role.codebuild.arn
}
