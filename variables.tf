# variable "env" {
#   type = string
#   default = "dev"
#   description = "Environment to be deployed"  
# }

variable "ext_port" {
  type = map(any)
  validation {
    condition     = max(var.ext_port["dev"]...) < 1885 && min(var.ext_port["dev"]...) > 1879
    error_message = "Ext_port should be 1880-1885."
  }
}

variable "image" {
  type        = map(any)
  description = "Image for containers"
  default = {
    nodered = {
    dev  = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
    dev  = "quay.io/influxdb/influxdb:v2.0.2"
    prod = "quay.io/influxdb/influxdb:v2.0.2"
    
    }
    
  }

}

locals {
  container_count = length(var.ext_port[terraform.workspace])
}
