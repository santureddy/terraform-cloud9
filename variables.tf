variable "env" {
  type = string
  default = "dev"
  description = "Environment to be deployed"  
}

variable "ext_port" {
  type = map
  validation {
      condition = max(var.ext_port["dev"]...) < 1885 && min(var.ext_port["dev"]...) > 1879
      error_message = "Ext_port should be 1880-1885."
  }
}

variable "image" {
    type = map
    description = "Image for containers"
    default = {
      dev = "nodered/node-red:latest"
      prod = "nodered/node-red:latest-minimal"
    }
    
}

locals {
  container_count = length(var.ext_port[var.env])
}
