output "ecs_cluster" {
  value = aws_ecs_cluster.cluster.name
}

output "cluster" {
  value = aws_ecs_cluster.cluster.name

}

output "service" {
  value = aws_ecs_service.ecs_service.name
}
