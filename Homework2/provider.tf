provider "aws" {
    region = "us-east-1"
}

# Upload public key to aws by providing a path of the key location 
resource "aws_key_pair" "keypair" {
  key_name   = "bastion-key"
  public_key = file("~/.ssh/id_rsa.pub") 
}