output "subnet_id" {
  value = aws_subnet.this.id
}

output "security_group_id" {
  value = aws_security_group.this.id
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}