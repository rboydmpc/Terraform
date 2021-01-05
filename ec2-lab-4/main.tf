#Provider Block
provider "aws" {
    region = "us-east-1"
}

#EC2 Block with Tags
resource "aws_instance" "Linux1" {
    ami = "ami-0be2609ba883822ec"
    instance_type = "t2.micro"
    #Add Tags
    tags = {
      "Name" = "Tiny Linux"
      "OS" = "Linux"
      "Class" = "Staging"
    }
}