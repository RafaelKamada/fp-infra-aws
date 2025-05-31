output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.subnet.id
}

output "security_group_id" {
  value = aws_security_group.sg.id
}

output "sqs_pedido_para_producao" {
  value = aws_sqs_queue.pedido_para_producao.url
}

output "sqs_pedido_para_pagamento" {
  value = aws_sqs_queue.pedido_para_pagamento.url
}