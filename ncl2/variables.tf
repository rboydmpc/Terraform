variable "access_key" {
}
variable "secret_key" {
}

variable "aws_account_id" {
  type = number
  description = "AWS account to deploy RDS Mysql cluster and resources."
  default = "<%=customOptions.awsAccountID%>"
  #default = "653234354353"
}

variable "vpc_id" {
  type = string
  description = "VPC in which to deploy RDS and resources."
  default = "vpc-0d9ff1c5e933e72e1"
}

variable "aws_region" {
  type = string
  description = "AWS region to deploy RDS Mysql cluster and resources."
  default = "us-east-1"
}

variable "project_name" {
  type = string
  description = "Name to prefix RDS Mysql cluster and resources."
  default = "NCL"
}

variable "owner" {
  type = string
  description = "Project Owner."
  default = "Boyd"
}

variable "environment" {
  type = string
  description = "Project Environment."
  default = "Prod"
}

variable "cost_center" {
  type = string
  description = "Project Cost Center"
  default = "100029"
}

# rds vars
variable "rds_subnet_1" {
  type = string
  description = "Subnets in which to deploy the RDS Mysql clusters."
  default = "BakerAZ2"
}

variable "rds_subnet_2" {
  type = string
  description = "Subnets in which to deploy the RDS Mysql clusters."
  default = "baker-AZ"
}

variable "rds_subnet_3" {
  type = string
  description = "Subnets in which to deploy the RDS Mysql clusters."
  default = "BakerAZ1"
}

variable "rds_engine_version" {
  type = string
  description = "RDS Mysql engine version."
  default = "5.7"
}

variable "rds_major_engine_version" {
  type = string
  description = "RDS Mysql major engine version."
  default = "5.7"
}

variable "rds_engine_family" {
  type = string
  description = "RDS Mysql engine family."
  default = "mysql5.7"
}

variable "rds_instance_type" {
  type = string
  description = "RDS Mysql cluster instance type."
  default = "db.t3.small"
}

variable "rds_disk_size" {
  type = number
  description = "Disk size for RDS Mysql cluster instances in GB."
  default = 10
}

variable "create_db_replica" {
  type = bool
  description = "Create a mysql DB replica or not."
  default = "false"
}

variable "db_instance_user" {
  type = string
  description = "Mysql DB instance username."
  default = "admin"
}

variable "db_instance_user_password" {
  type = string
  description = "Mysql DB instance username."
  default = "password1"
}

variable "db_multi_az_enable" {
  type = bool
  description = "Enable Multi-AZ deployment for RDS Cluster."
  default = false
}

variable "db_deletion_protection" {
  type = bool
  description = "Enable deletion protection mySQL db instance."
  default = false
}

variable "db_delete_automated_backups" {
  type = bool
  description = "Delete automated backups for mySQL db instance."
  default = true
}

variable "db_publicly_accessible" {
  type = bool
  description = "Enable or disable public accessibility for mySQL db instance."
  default = false
}

variable "db_skip_final_snapshot" {
  type = bool
  description = "create or skip fina snapshot creation for mySQL db instance."
  default = true
}

variable "db_performance_insights_enabled" {
  description = "Enable performance monitoring insights for mySQL db instance."
  type        = bool
  default = false
}

variable "db_kms_key_id" {
  type = string
  description = "KMS key id to encrypt data in mySQL db instance."
  default = "bdaaa764-b2a6-4f8f-b2ca-7e5caabe1fbd"
}

variable "db_backup_retention_period" {
  type = number
  description = "How long in days to retain backups."
  default = 10
}
