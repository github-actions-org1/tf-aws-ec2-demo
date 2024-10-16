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

### Use when executing on GitLab / GitHub 
# resource "aws_key_pair" "ssh_key" {
#   key_name   = "demo"
#   public_key = var.ssh_key_pair
# }

### Use for Jenkins pipleline
resource "aws_key_pair" "portfolio" {
  key_name   = "portfolio"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAJ7M38wDPnT8Wkd1ZbHEfmbg+DOF/LOQ0KzLlB5oHHKLWRPnRVYxf3hEyVMxK33GLj+XNw3woAHsO2cPN+RiCQ1Wa/NxoZGoJn57nj8H8j/18TW7dfD5+8GUND04AVb8AGa6t2yS55UUtaDK+tGUhNnUUPJBwUzfxLX01NcqRgyy/DOW+wL6h6ginuJJK2A+HtEYEFNjlqQmQ5NAiskfr9b0l456ZK3k/9ELq0O3trqBuHrbPlr8RqtRKgblqMB7mLlxy9oqLF/4/4ZNCuYsR5/pk1RZuSBhHGODamRR3E3L1uHlZLsaZxwQxMOysKG2og8YLnlFmOZKpQoxx3Ts6DIRpw8XitJlDDZSNjkx++pn/BOpXY7/fn/9xpanog7wfMp2YvuJ1B5L7+oaQgfn/GzoGqXk/yhO4JHs3IFlIaHzRlUncVjitxvUM6g7jaACpTVNZlb9zParvgwCuYwrFinGUR50uoCQNpyGPc2gkyliHN3uxmN7PZV7yH26B+pc= swilliams@MDLT002"
}

### Use when executing locally 
# resource "aws_key_pair" "ssh_key" {
#   key_name   = "terraform-key"
#   public_key = file("~/.ssh/id_rsa.pub")
# }

#####################################

### Use for Jenkins

#####################################

# # This utilizes the TLS provider to generate an SSH key
# resource "tls_private_key" "generated" {
#   algorithm = "RSA"
# }

# # This uses terraform local provider in terraform.tf to save the TLS key to a file called "webkey.pem" in my local file system.
# resource "local_file" "private_key_pem" {
#   content  = tls_private_key.generated.private_key_pem
#   filename = "webkey.pem"
# }

# #Generates a key pair in AWS using the previous TLS key file 
# resource "aws_key_pair" "ssh_key" {
#   key_name   = "webkey"
#   public_key = tls_private_key.generated.public_key_openssh

#   lifecycle {
#     ignore_changes = [key_name]
#   }
# }
