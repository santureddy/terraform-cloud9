# networking --variables.tf---
variable "vpc_cidr" {

}

variable "public_cidrs" {
  type = list(any)

}

variable "private_cidrs" {
  
}

variable "public_sn_count" {
  type = number
}

variable "private_sn_count" {
  type = number
}