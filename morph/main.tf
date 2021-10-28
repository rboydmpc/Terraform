#################################
##			Variables		   ##
#################################
variable "access_key" {

}
variable "secret_key" {
 
}

variable "db_name" {
    description = "DB Name"
    default = ""
}

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

variable "deletion_protection" {
    default = "false"
}

variable "snapshot_identifier"{
    default = ""
}


#################################
##     Provider		   ##
#################################
provider "aws" {
    region = "us-east-1"
    access_key = var.access_key
    secret_key = var.secret_key
}

#################################
##         Resources         ##
#################################
resource "aws_db_instance" "default" {
  allocated_storage    = var.allocated
  max_allocated_storage = var.max_allocated
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "test22131"
  username             = var.db_user
  password             = var.db_password
  parameter_group_name = "${aws_db_parameter_group.default.id}"
  apply_immediately         = false
  final_snapshot_identifier = "mysql-backup-final-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  snapshot_identifier = var.snapshot_identifier
  skip_final_snapshot       = false
  deletion_protection   = var.deletion_protection
  backup_retention_period = 2
  db_subnet_group_name = "test_subnet"
  publicly_accessible = "true"
  tags = {
          Name = "test-tag"
          Environment = "Prod"
          Author = "Effectual Terraform script"
         }

  
}
/**
  Parameter Group
*/
resource "aws_db_parameter_group" "default" {
  name        = lower("${var.db_name}-${formatdate("YYYY-MM-DD-hhmm", timestamp())}-pg")
  description = format("Parameter group for %s", var.db_name)
  family      = "mysql5.7"
  
  tags = {
    Name = "test-tag"
    Author = "Effectual Terraform script"
  } 

}



resource "aws_db_option_group" "db_group" {
  name                     = lower("${var.db_name}-${formatdate("YYYY-MM-DD-hhmm", timestamp())}-og")
  option_group_description = format("Option group for %s", var.db_name)
  engine_name              = "mysql"
  major_engine_version     = "5.7"

  
  tags = {
    Name = "test-tag" 
    Author = "Effectual Terraform script"
  } 
}

