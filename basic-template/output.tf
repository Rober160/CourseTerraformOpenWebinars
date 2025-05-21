output "server-ip" {
  value = aws_instance.webserver.public_ip
}

output "az" {
  value = data.aws_availability_zones.az.names
}
