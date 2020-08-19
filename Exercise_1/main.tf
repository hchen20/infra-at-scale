# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  region = "us-east-1"
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity1" {
  count = "4"
  ami = "ami-0323c3dd2da7fb37d"
  instance_type = "t2.small"
  tags = {
    Name = "Udacity T2"
  }
}
# TODO: provision 2 m4.large EC2 instances named Udacity M4
# Code removed per review and removing two instances of M2. See previous commit for code
