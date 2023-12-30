# EC2 Instance
resource "aws_instance" "ec2-demo" {
  ami                    = data.aws_ami.amzlinux2.id
  instance_type          = var.instance_type
  user_data              = file("files/install-demo.sh")
  key_name               = aws_key_pair.ssh_key.key_name
  # public_key = var.ssh_key_pair
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-demo.id]
  tags = {
    "Name" = "ec2-demo"
  }
}