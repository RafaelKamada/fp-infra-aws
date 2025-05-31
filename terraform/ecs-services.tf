resource "aws_ecs_task_definition" "food_order_pedidos" {
  family                   = "food_order_pedidos"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = var.lab_role_arn
  task_role_arn            = var.lab_role_arn

  container_definitions = jsonencode([{
    name      = "food_order_pedidos"
    image     = "vilacaro/pedido:latest"
    portMappings = [{
      containerPort = 8080
      protocol      = "tcp"
    }]
    essential = true
    environment = [
      { name = "AWS_ACCESS_KEY_ID", value = "000000000000" },
      { name = "AWS_SECRET_ACCESS_KEY", value = "000000000000" },
      { name = "AWS_DEFAULT_REGION", value = var.aws_region },
      { name = "AWS_ENDPOINT_URL", value = "http://localstack:4566" }
    ]
    command = [
      "sh", "-c",
      "until pg_isready -h postgres -p 5432 -U postgres; do echo 'Aguardando PostgreSQL...'; sleep 2; done && dotnet ef database update --project FoodOrder.Pedidos/src/FoodOrder.Pedidos.Infrastructure/FoodOrder.Pedidos.Infrastructure.csproj --startup-project FoodOrder.Pedidos/src/FoodOrder.Pedidos.Presentation/FoodOrder.Pedidos.Presentation.csproj && dotnet FoodOrder.Pedidos.Presentation.dll"
    ]
  }])
}

resource "aws_ecs_service" "food_order_pedidos" {
  name            = "food_order_pedidos"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.food_order_pedidos.arn
  desired_count   = var.ecs_desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = module.vpc.public_subnets
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }
  depends_on = [aws_ecs_cluster.main, aws_ecs_service.postgres]
}

# Repita para os outros serviços conforme a mesma estrutura (food_order_pagamento, food_order_producao, food_order_usuario, food_order_cardapio)
