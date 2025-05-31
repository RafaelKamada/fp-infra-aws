output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_a_id" {
  value = aws_subnet.public_a.id
}

output "subnet_b_id" {
  value = aws_subnet.public_b.id
}

output "security_group_id" {
  value = aws_security_group.ecs_services.id
}

output "sqs_pedido_para_producao" {
  value = aws_sqs_queue.pedido_para_producao.id
}

output "sqs_pedido_para_pagamento" {
  value = aws_sqs_queue.pedido_para_pagamento.id
}
