output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "ecs_security_group_id" {
  value = aws_security_group.ecs_sg.id
}

output "postgres_service_name" {
  value = aws_ecs_service.postgres.name
}

output "mongo_service_name" {
  value = aws_ecs_service.mongo.name
}
