provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "lab2"{
    ami = "ami-0be2609ba883822ec"
    instance_type = "t2.micro"
    tags = {
        Name = "Windows 2019"
        service = "Test"
    }
}