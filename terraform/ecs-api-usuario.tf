resource "aws_ecs_task_definition" "usuario" {
  family                   = "usuario-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "usuario"
      image     = "vilacaro/api:latest"
      essential = true
      portMappings = [{
        containerPort = 5004
        hostPort      = 5004
      }]
    }
  ])
}

resource "aws_ecs_service" "usuario" {
  name            = "usuario"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.usuario.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_groups = [aws_security_group.ecs_services.id]
    assign_public_ip = true
  }
}
