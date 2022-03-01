terraform {
   required_version = ">= 0.12.31"

   required_providers {
     aws = ">= 3.68"
   }
}



provider "aws" {
    region = "us-east-1"
    access_key = var.access_key
    secret_key = var.secret_key
}

variable "access_key" {}

variable "secret_key" {}

variable "bucket_name" {}

variable "acl_value" {
    default = "private"
}

variable "test" {
    default = ""
}

variable "ami_id" {
      type = string

#      validation {
#        condition = (
#          length(var.ami_id) > 4 &&
#          substr(var.ami_id, 0, 4) == "ami-"
#        )
#        error_message = "The ami_id value must start with \"ami-\"."
#      }
    }

resource "aws_s3_bucket" "demos3" {
    bucket = var.bucket_name
    acl = var.acl_value

    tags = {
    Name = var.bucket_name
    Date = timestamp()
    }
}
