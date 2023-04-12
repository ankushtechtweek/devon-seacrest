output "ecr_repo_url" {
  value = aws_ecr_repository.ecr-repo.repository_url
}

output "ecr_repo" {
  value = aws_ecr_repository.ecr-repo.name
}
