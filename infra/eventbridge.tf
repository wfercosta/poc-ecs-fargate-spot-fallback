resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/events/${aws_cloudwatch_event_rule.this.name}"
}

resource "aws_cloudwatch_event_rule" "this" {
  name        = "service-task-placement-failure"
  description = "Capture all events of ECS service that occurs service task placement failure"

  event_pattern = templatefile("./_templates/eventbridge_event_pattern.tftpl", {
    primary_service_arn = aws_ecs_service.spot.id
  })
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    effect = "Allow"

    resources = [
      "${aws_cloudwatch_log_group.this.arn}:*"
    ]

    principals {
      identifiers = ["events.amazonaws.com", "delivery.logs.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "this" {
  policy_document = data.aws_iam_policy_document.this.json
  policy_name     = "policy-cloudwatch-logs-${aws_cloudwatch_event_rule.this.name}"
}

resource "aws_cloudwatch_event_target" "log" {
  rule = aws_cloudwatch_event_rule.this.name
  arn  = aws_cloudwatch_log_group.this.arn
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule = aws_cloudwatch_event_rule.this.name
  arn  = module.fn-on-demand-scale-in-out.arn

  input_transformer {
    input_paths = {
      event_type = "$.detail.eventName"
    }
    input_template = templatefile("./_templates/eventbridge_input_template.tftpl", {
      primary_service_arn   = aws_ecs_service.spot.id,
      secondary_service_arn = aws_ecs_service.ondemand.id,
      cluster_arn           = aws_ecs_cluster.this.arn
    })
  }
}
