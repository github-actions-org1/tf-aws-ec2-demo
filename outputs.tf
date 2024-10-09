output "public_ip" {
  value       = formatlist("%s: %s", aws_instance.portfolio.*.public_dns, aws_instance.portfolio.*.public_ip)
}

output "instance_id" {
  value       = aws_instance.portfolio.*.id
  description = "Instance ID"
}

output "ssh_connection" {
  value       = "ssh ec2-user@${aws_instance.portfolio.public_ip}"
}

output "web_connection" {
  value       = "http://${aws_instance.portfolio.public_ip}"
}

output "portfolio_url" {
  value = "http://portfolio.emagetech.co"
}
