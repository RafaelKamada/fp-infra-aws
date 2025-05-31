resource "aws_ecs_task_definition" "api_pedido" {
  family                   = "api-pedido"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  container_definitions = jsonencode([{
    name  = "api-pedido"
    image = "vilacaro/pedido:latest"
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
    }]
    environment = []
  }])
}

resource "aws_ecs_service" "api_pedido" {
  name            = "api-pedido"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.api_pedido.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.this.id]
    security_groups = [aws_security_group.this.id]
    assign_public_ip = true
  }
}