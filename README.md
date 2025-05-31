
# Infraestrutura Completa - FoodOrder

Este projeto contém os arquivos Terraform para subir toda a infraestrutura do FoodOrder na AWS utilizando ECS Fargate.

## Serviços Incluídos:
- Pedido
- Pagamento
- Produção
- Cardápio
- Usuários
- Mock Server
- MongoDB (Fargate)
- PostgreSQL (Fargate)
- 2 filas SQS

## Passos para Deploy:
1. Configure suas credenciais AWS (`LabRole`).
2. Execute:
   terraform init
   terraform apply

