resource "aws_ecs_task_definition" "mongo" {
  family                   = "mongo-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  container_definitions = jsonencode([
    {
      name      = "mongo"
      image     = "mongo:latest"
      essential = true
      portMappings = [{
        containerPort = 27017
        hostPort      = 27017
      }]
    }
  ])
}

resource "aws_ecs_service" "mongo" {
  name            = "mongo"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.mongo.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_groups = [aws_security_group.ecs_services.id]
    assign_public_ip = true
  }
}
