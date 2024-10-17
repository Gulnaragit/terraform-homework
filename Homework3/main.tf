provider aws {
    region = "us-west-2"
}

resource "aws_key_pair" "keypair" {
  key_name   = "bastion-key"
  public_key = file("~/.ssh/id_rsa.pub") 

  tags = local.common_tags
}

data "aws_ami" "amazon-linux-2" {
 most_recent = true

 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }

 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

resource "aws_instance" "web" {
    ami = data.aws_ami.amazon-linux-2.id
    instance_type = "t2.micro"
    key_name  = aws_key_pair.keypair.key_name
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
    availability_zone = "${element(var.az,count.index)}"
    user_data = file("apache.sh")
    count = 3
    
    tags = {
        Name = "${element(var.ec2_names,count.index)}"
        }
}