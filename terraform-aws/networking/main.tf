# networking --main.tf---

data "aws_availability_zones" "available" {
  
}
resource "random_integer" "random" {
  min = 1
  max = 100
}

resource "random_shuffle" "az_list" {
  input = data.aws_availability_zones.available.names
  result_count = var.max_subnets
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
  count                   = var.public_sn_count
  vpc_id                  = aws_vpc.santy_vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = random_shuffle.az_list.input[count.index]
  tags = {
    Name = "santy_public_${count.index + 1}"
  }
}

resource "aws_subnet" "santy_subnet_private" {
  count                   = var.private_sn_count
  vpc_id                  = aws_vpc.santy_vpc.id
  cidr_block              = var.private_cidrs[count.index]
  availability_zone       = random_shuffle.az_list.input[count.index]
  tags = {
    Name = "santy_private_${count.index + 1}"
  }
}