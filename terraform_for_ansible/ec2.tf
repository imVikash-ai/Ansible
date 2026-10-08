# create key-pair for ec2 instance
resource "aws_key_pair" "my_key_pair" {
  key_name   = "terra-key-ansible"
  public_key = file("terra-key-ansible.pub")

}

# VPC & Security Group
resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = "This will add a TF generated security group"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "automate-sg"
  }

  # inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "my-instance" {

  for_each = tomap({
    Master     = "ami-0e5497a77ef21b5ac" #Ubuntu
    instance-1 = "ami-0e5497a77ef21b5ac" # Ubuntu
    instance-2 = "ami-008f67e1a087a7449" # RedHat
    instance-3 = "ami-0d3d85815a9746bc5" # Amazon Linux 2
  })

  # depends_on = [aws_security_group.my_security_group]   

  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  instance_type          = "t3.micro"
  ami                    = each.value
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
  tags = {
    Name = each.key
    Environment = var.env
  }


}