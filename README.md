# Infraestrutura - Food Order

## 🚀 Pré-requisitos
- Conta AWS (AWS Academy)
- Terraform instalado

## 🔧 Comandos Terraform

```bash
terraform init
terraform plan
terraform apply
```

## 🏗️ Recursos Criados
- VPC com subnet pública
- Internet Gateway e roteamento
- Security Group liberando todas as portas TCP (ajustável)
- ECS Fargate rodando:
  - MongoDB
  - PostgreSQL
  - APIs (Pedidos, Cardápio, Pagamento, Produção, Usuários)
  - Mock Server
- 2 filas SQS:
  - pedido-para-producao
  - pedido-para-pagamento

## 🧹 Destroy

```bash
terraform destroy
```

## 🌐 Acesso às APIs
- IPs públicos estarão disponíveis no output do Terraform.
- As portas seguem seu `docker-compose`:
  - Pedido → 8080
  - Cardápio → 4003
  - Pagamento → 4000
  - Produção → 4002
  - Usuários → 4004
  - Mock → 4001

---