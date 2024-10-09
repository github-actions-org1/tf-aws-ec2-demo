# EC2 Instance
resource "aws_instance" "portfolio" {
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  user_data     = file("files/install-portfolio.sh")
  key_name      = aws_key_pair.portfolio.key_name
  # public_key = var.portfolio_pair
  vpc_security_group_ids = [aws_security_group.portfolio.id]
  tags = {
    Name        = "developers-portfolio"
    Environment = "Developement"
    OS          = "RedHat Linux"
    Managed     = "Terraform"
  }
}