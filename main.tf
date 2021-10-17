locals {
  deployment = {
    nodered = {
      image = var.image["nodered"][terraform.workspace]
      int = 1880
      ext = var.ext_port["nodered"][terraform.workspace]
      container_path = "/data"

    }
    influxdb = {
      image = var.image["influxdb"][terraform.workspace]
      int = 8086
      ext = var.ext_port["influxdb"][terraform.workspace]
      container_path = "/var/lib/influxdb"
    }
  }
}


module "image" {
  source   = "./image"
  for_each = local.deployment
  image_in = each.value.image
}

resource "random_string" "random" {
  for_each = local.deployment
  length  = 4
  special = false
}

module "container" {
  source      = "./container"
  for_each = local.deployment
  image_in    = module.image[each.key].image_out
  name_in     = join("-", [each.key, random_string.random[each.key].result])
  int_port_in = each.value.int
  #external = 1880
  ext_port_in       = each.value.ext[0]
  container_path_in = each.value.container_path

}

