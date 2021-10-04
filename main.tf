terraform {
  required_providers {

    docker = {
      source = "kreuzwerker/docker"
    }

  }
}

provider "docker" {}

resource "docker_image" "nodered_image" {
  name = var.image[terraform.workspace]
}

resource "random_string" "random" {
  count   = local.container_count
  length  = 4
  special = false
}

resource "null_resource" "dockervol" {
  provisioner "local-exec" {
    command = "mkdir ${path.cwd}/noderedvol || true && chown -R 1000:1000 noderedvol/"
  }

}

resource "docker_container" "nodered_container" {
  count = local.container_count
  image = docker_image.nodered_image.latest
  name  = join("-", ["nodered", random_string.random[count.index].result])
  ports {
    internal = 1880
    #external = 1880
    external = lookup(var.ext_port, terraform.workspace)[count.index]
  }
  volumes {
    container_path = "/data"
    host_path      = "${path.cwd}/noderedvol"

  }
}

