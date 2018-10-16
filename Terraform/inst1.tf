resource "aws_instance" "example" {
  ami = "ami-5b673c34"
  instance_type = "t2.micro"
  key_name = "mac-key"

tags {
  Name = "inst1_deploy_aws1"
  }
}

resource "aws_instance" "example-new2" {
  ami = "ami-5b673c34"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.aws-mac-key.key_name}"
  security_groups = ["${aws_security_group.allow_ssh.name}"]
  count = 3

tags {
  Name = "inst2_deploy_aws2"
  }
}

resource "aws_key_pair" "aws-mac-key" {
  key_name   = "aws_mac_key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "example_public_dns" {
  value = "${aws_instance.example-new2.*.public_dns}"
}
