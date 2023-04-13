output "ecs_cluster" {
  value = aws_ecs_cluster.cluster.name
}

output "ecs_service" {
  value = aws_ecs_service.ecs_service.name
}
