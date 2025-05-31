# FoodOrder AWS Terraform Deployment

## Requisitos
- Terraform CLI >= 1.3.0
- AWS CLI configurado para acessar sua conta com a role LabRole (padrão AWS Academy)

## Variáveis configuráveis
- aws_region (default: us-east-1)
- lab_role_arn (default: arn:aws:iam::618817506326:role/LabRole)
- project_name (default: foodorder)

## Como usar

1. Clone este repositório.

2. Inicialize o Terraform:
```bash
terraform init
