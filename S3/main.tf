terraform {
   required_version = ">= 0.12.31"

   required_providers {
     aws = "= 3.64"
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

resource "aws_s3_bucket" "demos3" {
    bucket = var.bucket_name
    acl = var.acl_value

    tags = {
    Name = var.bucket_name
    Date = timestamp()
    }
}
