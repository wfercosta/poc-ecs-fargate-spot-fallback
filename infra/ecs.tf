resource "aws_ecs_cluster" "this" {
  name = "demo"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
resource "aws_ecs_task_definition" "this" {
  family                   = "httpbin-td-family"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name      = "httpbin"
      image     = "kennethreitz/httpbin"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}


resource "aws_ecs_service" "ondemand" {
  name            = "httpbin-service-fargate-od"
  cluster         = aws_ecs_cluster.this.name
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 0

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
  }

  network_configuration {
    subnets          = [sort(data.aws_subnets.this.ids)[0], sort(data.aws_subnets.this.ids)[1]]
    assign_public_ip = true
  }
}


resource "aws_ecs_service" "spot" {
  name            = "httpbin-service-fargate-spot"
  cluster         = aws_ecs_cluster.this.name
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 2

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  network_configuration {
    subnets          = [sort(data.aws_subnets.this.ids)[0], sort(data.aws_subnets.this.ids)[1]]
    assign_public_ip = true
  }
}




