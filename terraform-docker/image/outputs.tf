output "image_out" {
  value       = docker_image.container_image.latest
  description = "Image name from module"
}
