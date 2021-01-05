provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "win2019" {
  ami = "ami-0229f7666f517b31e"
  instance_type = "t2.micro"
}