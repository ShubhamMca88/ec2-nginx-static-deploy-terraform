output "instance_id" {
  value = aws_instance.ec2.id
}

output "public_ip" {
  value = aws_instance.ec2.public_ip
}

output "public_dns" {
  value = aws_instance.ec2.public_dns
}

output "elastic_ip" {
  description = "Elastic IP attached to the EC2 instance"
  value       = aws_eip.ec2_eip.public_ip
}
