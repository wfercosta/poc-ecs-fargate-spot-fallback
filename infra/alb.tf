resource "aws_lb" "this" {
  name               = "demo-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [sort(data.aws_subnets.this.ids)[0], sort(data.aws_subnets.this.ids)[1]]

  enable_deletion_protection = false

}
