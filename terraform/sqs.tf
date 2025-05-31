resource "aws_sqs_queue" "pedido_para_producao" {
  name = "pedido-para-producao"
}

resource "aws_sqs_queue" "pedido_para_pagamento" {
  name = "pedido-para-pagamento"
}
