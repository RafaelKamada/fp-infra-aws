# 🚀 Infraestrutura Food Order com Terraform

## ✅ Serviços

- MongoDB (Fargate)
- PostgreSQL (Fargate)
- API Usuário (`vilacaro/api`)
- API Cardápio (`japamanoel/foodorder_cardapio`)
- API Pedido (`vilacaro/pedido`)
- API Pagamento (`diegogl12/food-order-pagamento`)
- API Produção (`diegogl12/food-order-producao`)
- 2 Filas SQS

## 🔧 Como usar

1. Configure suas credenciais AWS (Terraform Cloud, AWS CLI ou env vars).
2. Execute:

```bash
terraform init
terraform plan
terraform apply
