provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "flask_server" {
  ami           = "ami-0dee22c13ea7a9a67"  # Amazon Linux 2 (Mumbai)
  instance_type = "t2.micro"
  key_name      = "yash-key"                # Replace with your AWS key pair name

  tags = {
    Name = "FlaskAppServer"
  }
}
