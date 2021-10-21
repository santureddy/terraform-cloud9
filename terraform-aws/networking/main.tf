# networking --main.tf---
resource "random_integer" "random" {
  min = 1
  max = 100
}

resource "aws_vpc" "santy_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "santy-vpc-${random_integer.random.id}"
  }
}

resource "aws_subnet" "santy_subnet_public" {
  count                   = length(var.public_sn_count)
  vpc_id                  = aws_vpc.santy_vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"][count.index]
  tags = {
    Name = "santy_public_${count.index + 1}"
  }
}

esource "aws_subnet" "santy_subnet_private" {
  count                   = length(var.private_sn_count)
  vpc_id                  = aws_vpc.santy_vpc.id
  cidr_block              = var.private_cidrs[count.index]
  availability_zone       = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"][count.index]
  tags = {
    Name = "santy_private_${count.index + 1}"
  }
}