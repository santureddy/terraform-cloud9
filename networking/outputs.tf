# networking --outputs.tf---
output "vpc_id" {
  value = aws_vpc.santy_vpc.id
}