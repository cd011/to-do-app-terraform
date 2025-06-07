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
}