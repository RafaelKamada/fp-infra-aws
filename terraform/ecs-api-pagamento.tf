resource "aws_ecs_task_definition" "pagamento" {
  family                   = "pagamento-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "pagamento"
      image     = "diegogl12/food-order-pagamento:latest"
      essential = true
      portMappings = [{
        containerPort = 5002
        hostPort      = 5002
      }]
    }
  ])
}

resource "aws_ecs_service" "pagamento" {
  name            = "pagamento"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.pagamento.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    security_groups = [aws_security_group.ecs_services.id]
    assign_public_ip = true
  }
}
