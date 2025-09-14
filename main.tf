# first terraform project
resource "docker_image" "nginx" {
  name = var.containers.nginx.image
  keep_locally = true
}
resource "docker_image" "wordpress" {
  name = var.containers.wordpress.image
  keep_locally = true
}
resource "docker_container" "nginx" {
  name  = "project-${var.containers.nginx.name}"
  image = docker_image.nginx.image_id
  ports {
    internal = var.containers.nginx.ports.internal
    external = var.containers.nginx.ports.external
  }
}
resource "docker_container" "wordpress" {
  name  = "project-${var.containers.wordpress.name}"
  image = docker_image.wordpress.image_id
  ports {
    internal = var.containers.wordpress.ports.internal
    external = var.containers.wordpress.ports.external
  }
}
resource "random_password" "uniq_name" {
  length = 16
}
resource "local_file" "temp_junk" {
  content = "project-${random_password.uniq_name.result}"
  filename = "/tmp/temp_junk"
}