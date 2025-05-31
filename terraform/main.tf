module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"

  name                 = var.project_name
  cidr                 = var.vpc_cidr
  azs                  = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets       = var.public_subnet_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Project = var.project_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = module.vpc.public_subnets[0]
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.project_name}-nat"
  }
}

resource "aws_eip" "nat" {
  vpc = true
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

resource "aws_route_table_association" "public_subnet_a" {
  subnet_id      = module.vpc.public_subnets[0]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet_b" {
  subnet_id      = module.vpc.public_subnets[1]
  route_table_id = aws_route_table.public.id
}
