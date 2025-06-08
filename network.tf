# VPC
resource "aws_vpc" "main" {
  cidr_block       = var.VPC_CIDR
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc-tf"
  }
}

# Subnets
resource "aws_subnet" "subnets" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = each.value.name
  }
  depends_on = [aws_vpc.main]
}

# Internet-Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-tf-igw"
  }
}

# Create routing tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-tf-rt-pub"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-tf-rt-pvt"
  }
}

# Route table association
resource "aws_route_table_association" "rt_associations" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  subnet_id      = aws_subnet.subnets[each.key].id
  route_table_id = each.value.type == "public" ? aws_route_table.public.id : aws_route_table.private.id
  depends_on     = [aws_subnet.subnets, aws_route_table.public, aws_route_table.private]
}

# 
resource "aws_route" "r" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}