resource "aws_ecs_task_definition" "producao" {
  family                   = "producao-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "producao"
      image     = "diegogl12/food-order-producao:latest"
      essential = true
      portMappings = [{
        containerPort = 5003
        hostPort      = 5003
      }]
    }
  ])
}

resource "aws_ecs_service" "producao" {
  name            = "producao"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.producao.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_groups = [aws_security_group.ecs_services.id]
    assign_public_ip = true
  }
}
