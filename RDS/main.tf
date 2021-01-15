#################################
##      Variables	       ##
#################################
variable "access_key {}
variable "secret_key {}
variable "allocated" {
    description = "DB Size in GB"
    default = "20"
}
variable "max_allocated" {
    description = "Max Autogrow DB Size in GB"
    default = "100"
}
variable "db_user" {
    description = "DB User"
    default = "admin"
}
variable "db_password" {
    description = "DB Password"
}
variable "apply_immediately" {
    description = "Apply Changes Immediatly"
    default = "true"
}


#variable "var1" {
#  type        = list(string)
#  default = [
#    "5.5",
#    "5.6",
#    "5.7",
#    "8.0"
#  ]
#}
#################################
##			Provider		   ##
#################################
provider "aws" {
    region = "us-east-1"
    access_key = var.access_key
    secret_key = var.secret_key
}

#################################
##		  Resources         ##
#################################
resource "aws_db_instance" "default" {
  allocated_storage    = var.allocated
  max_allocated_storage = var.max_allocated
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = var.db_user
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  apply_immediately         = var.apply_immediately
  final_snapshot_identifier = "mysql-backup"
  skip_final_snapshot       = true
}