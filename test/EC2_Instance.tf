provider "aws" {
  region = "us-east-1"  # Replace with your desired region
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"

}
# test/EC2_Instance.tf
resource "aws_security_group" "django_docker_aws" {
  name_prefix = "django_docker_aws"
  description = "Security group for Django and Docker on AWS"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "nucamp_private_key" {
  key_name   = "nucamp-private-key"
  public_key = file("~/.ssh/nucamp-private-key.pub")  # Replace with your desired public key path
}

resource "aws_instance" "example" {
  ami           = "ami-0dba2cb6798deb6d8"  # Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
  instance_type = "t2.micro"

  vpc_security_group_ids = [
    aws_security_group.django_docker_aws.id,
  ]

  key_name = aws_key_pair.nucamp_private_key.key_name

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/nucamp-private-key")  # Replace with your desired private key path
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Instance ID: ${self.id}'",
    ]
  }
}

output "public_key" {
  value = aws_key_pair.nucamp_private_key.public_key
}

