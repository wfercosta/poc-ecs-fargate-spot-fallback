# resource "aws_ecs_cluster" "this" {
#   name = "ecs-cluster"

#   setting {
#     name  = "containerInsights"
#     value = "enabled"
#   }
# }

# resource "aws_ecs_cluster_capacity_providers" "this" {
#   cluster_name       = aws_ecs_cluster.this.name
#   capacity_providers = ["FARGATE", "FARGATE_SPOT"]
# }
