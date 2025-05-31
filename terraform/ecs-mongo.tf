resource "aws_ecs_task_definition" "mongo" {
  family                   = "${var.project_name}-mongo"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = var.lab_role_arn
  task_role_arn            = var.lab_role_arn

  container_definitions = jsonencode([{
    name      = "mongo"
    image     = "mongo:latest"
    portMappings = [{
      containerPort = 27017
      protocol      = "tcp"
    }]
    essential = true
  }])
}

resource "aws_ecs_service" "mongo" {
  name            = "${var.project_name}-mongo"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.mongo.arn
  desired_count   = var.ecs_desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = module.vpc.public_subnets
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }
  depends_on = [aws_ecs_cluster.main]
}
