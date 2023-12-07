# resource "aws_key_pair" "webkey" {
#   key_name   = "web-key"
#   public_key = tls_private_key.oskey.public_key_openssh
# }

# resource "tls_private_key" "oskey" {
#   algorithm = "RSA"
# }

# resource "local_file" "key" {
#   content  = tls_private_key.oskey.private_key_pem
#   filename = "web-key.pem"
# }

### Use when executing on GitLab 
# resource "aws_key_pair" "ssh_key" {
#   key_name   = "ssh_key"
#   public_key = var.ssh_key_pair
# }

### Use when executing locally 

resource "aws_key_pair" "ssh_key" {
  key_name   = "terraform-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
