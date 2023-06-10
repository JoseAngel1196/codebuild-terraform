data "aws_iam_policy_document" "role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    effect = "Allow"
  }

  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "permissions" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "codebuild:CreateReportGroup",
      "codebuild:CreateReport",
      "codebuild:UpdateReport",
      "codebuild:BatchPutTestCases",
      "codebuild:BatchPutCodeCoverages"
    ]
    resources = [aws_codebuild_project.codebuild_project.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "codebuild:StartBuild"
    ]
    resources = [aws_codebuild_project.codebuild_project.arn]
  }
}

resource "aws_iam_role" "codebuild" {
  name               = "codebuild-${var.service_name}-service-role"
  assume_role_policy = data.aws_iam_policy_document.role.json
}


resource "aws_iam_policy" "codebuild_policy" {
  name   = "codebuild-${var.service_name}-base-policy"
  policy = data.aws_iam_policy_document.permissions.json
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment" {
  policy_arn = aws_iam_policy.codebuild_policy.arn
  role       = aws_iam_role.codebuild.name
}
