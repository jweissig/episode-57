// configure API access (user with AmazonEC2FullAccess)
provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
  region = "us-west-2"
}

// Amazon Linux 2 AMI (HVM), SSD Volume, 64-bit x86
// https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "web1" {
  ami = "ami-032509850cf9ee54e"
  instance_type = "t1.micro"
  //tags {
  //  Name = "web1-tf"
  //}
}
