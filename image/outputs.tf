output "image_out" {
  value       = docker_image.nodered_image.latest
  description = "Image name from module"
}
