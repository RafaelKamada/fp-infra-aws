resource "aws_ecs_task_definition" "postgres" {
  family                   = "${var.project_name}-postgres"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = var.lab_role_arn
  task_role_arn            = var.lab_role_arn

  container_definitions = jsonencode([{
    name      = "postgres"
    image     = "postgres:15"
    portMappings = [{
      containerPort = 5432
      protocol      = "tcp"
    }]
    environment = [
      { name = "POSTGRES_PASSWORD", value = "postgres" },
      { name = "POSTGRES_USER",     value = "postgres" },
      { name = "POSTGRES_DB",       value = "foodorder_pedidos_db" }
    ]
    essential = true
  }])
}

resource "aws_ecs_service" "postgres" {
  name            = "${var.project_name}-postgres"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.postgres.arn
  desired_count   = var.ecs_desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = module.vpc.public_subnets
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }
  depends_on = [aws_ecs_cluster.main]
}
