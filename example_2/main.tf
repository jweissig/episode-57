// configure API access (user with AmazonEC2FullAccess)
provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
  region = "us-west-2"
}

// Amazon Linux 2 AMI (HVM), SSD Volume, 64-bit x86
// https://www.terraform.io/docs/providers/aws/r/instance.html
// https://www.terraform.io/docs/providers/aws/r/instance.html#user_data
// https://aws.amazon.com/amazon-linux-2/faqs/#Amazon_Linux_Extras
resource "aws_instance" "web1" {
  ami = "ami-032509850cf9ee54e"
  instance_type = "t1.micro"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1.12
              echo "#57 - Terraform (web1)" > /usr/share/nginx/html/index.html
              systemctl enable nginx
              systemctl start nginx
              EOF
  tags {
    Name = "web1-tf"
  }
}

// web2
resource "aws_instance" "web2" {
  ami = "ami-032509850cf9ee54e"
  instance_type = "t1.micro"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1.12
              echo "#57 - Terraform (web2)" > /usr/share/nginx/html/index.html
              systemctl enable nginx
              systemctl start nginx
              EOF
  tags {
    Name = "web2-tf"
  }
}

// https://www.terraform.io/docs/providers/aws/d/security_group.html
resource "aws_security_group" "web" {
  name = "ingress-web-http"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// https://www.terraform.io/docs/providers/aws/r/elb.html
resource "aws_elb" "tf-elb" {
  name = "tf-elb"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }
  instances = ["${aws_instance.web1.id}", "${aws_instance.web2.id}"]
  tags = {
    Name = "tf-elb"
  }
}
