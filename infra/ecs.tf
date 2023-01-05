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

resource "aws_lb_target_group" "this" {
  name        = "httpbin-service-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.this.id
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_ecs_service" "ondemand" {
  name            = "httpbin-service-fargate-fallback-ondemand"
  cluster         = aws_ecs_cluster.this.name
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 0

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
  }

  network_configuration {
    subnets          = [sort(data.aws_subnets.this.ids)[0], sort(data.aws_subnets.this.ids)[1]]
    security_groups  = [aws_security_group.ecs-service.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = "httpbin"
    container_port   = 80
  }

}


resource "aws_ecs_service" "spot" {
  name            = "httpbin-service-fargate"
  cluster         = aws_ecs_cluster.this.name
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 2

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  network_configuration {
    subnets          = [sort(data.aws_subnets.this.ids)[0], sort(data.aws_subnets.this.ids)[1]]
    security_groups  = [aws_security_group.ecs-service.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = "httpbin"
    container_port   = 80
  }
}




