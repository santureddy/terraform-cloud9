# output "container_name" {
#   value       = docker_container.nodered_container[*].name
#   description = "Names of docker containers"
# }

# output "container_ip" {
#   value = [for i in docker_container.nodered_container[*] : join(":", [i.ip_address], i.ports[*]["external"])]
#   # can be done as below as well
#   #value = [for i in docker_container.nodered_container[*] : join(":", [i.ip_address], [i.ports[0]["external"]])]
# }