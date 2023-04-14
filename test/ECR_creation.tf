
// Create an ECR private repository with the name django_docker_aws
resource "aws_ecr_repository" "django_docker_aws" {
  name = "django_docker_aws"
}
// Print the URI of the ECR repository within terraform output
output "django_docker_aws_ecr_uri" {
  value = aws_ecr_repository.django_docker_aws.repository_url
}

