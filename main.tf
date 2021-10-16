locals {
  deployment = {
    nodered = {
      image = var.image["nodered"][terraform.workspace]
    } 
    influxdb = {
      image = var.image["influxdb"][terraform.workspace]
    }
  }
}


module "image" {
  source   = "./image"
  for_each = local.deployment
  image_in = each.value.image
}

resource "random_string" "random" {
  count   = local.container_count
  length  = 4
  special = false
}

module "container" {
  source      = "./container"
  count       = local.container_count
  image_in    = module.image["nodered"].image_out
  name_in     = join("-", ["nodered", random_string.random[count.index].result])
  int_port_in = 1880
  #external = 1880
  ext_port_in       = var.ext_port[terraform.workspace][count.index]
  container_path_in = "/data"

}

