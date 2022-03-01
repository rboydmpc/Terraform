terraform {
   required_version = ">= 0.12.0"

   required_providers {
     aws = "< 4.0.0"
   }
}


provider "aws" {
    region = "us-east-1"
    access_key = var.access_key
    secret_key = var.secret_key
}
