# Allocate Elastic IP
resource "aws_eip" "ec2_eip" {
  instance = aws_instance.ec2.id

  tags = merge(var.tags, {
    Name = "${var.instance_name}-eip"
  })
}

resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.shb-key.key_name
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data              = file("nginx_server.sh")

  associate_public_ip_address = true

  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp3"
    encrypted   = true
  }

  tags = merge(var.tags, {
    Name = var.instance_name
  })
}
