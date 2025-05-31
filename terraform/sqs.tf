resource "aws_sqs_queue" "pedidos_producao" {
  name = "${var.project_name}-pedidos-producao-queue"
}

resource "aws_sqs_queue" "pedidos_pagamento" {
  name = "${var.project_name}-pedidos-pagamento-queue"
}
