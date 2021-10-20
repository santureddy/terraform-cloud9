# root --main.tf---

module "networking" {
  source       = "./networking"
  vpc_cidr     = "10.122.0.0/16"
  public_cidrs = ["10.122.2.0/24", "10.122.4.0/24"]

}