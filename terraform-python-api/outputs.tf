output "api_public_ip" {
  value = aws_instance.python_api.public_ip
}

output "health_endpoint" {
  value = "http://${aws_instance.python_api.public_ip}:5000/health"
}
