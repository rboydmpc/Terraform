variable "access_key" {
  
}
variable "secret_key" {
}

variable "aws_account_id" {
  type = number
  description = "AWS account to deploy RDS Mysql cluster and resources."
}

variable "vpc_id" {
  type = string
  description = "VPC in which to deploy RDS and resources."
}

variable "aws_region" {
  type = string
  description = "AWS region to deploy RDS Mysql cluster and resources."
}

variable "project_name" {
  type = string
  description = "Name to prefix RDS Mysql cluster and resources."
  default     = "<%=instance.name%>"
}

variable "owner" {
  type = string
  description = "Project Owner."
}

variable "environment" {
  type = string
  description = "Project Environment."
}

variable "cost_center" {
  type = string
  description = "Project Cost Center"
}

# rds vars
variable "rds_subnet_1" {
  type = string
  description = "Subnets in which to deploy the RDS Mysql clusters."
}

variable "rds_subnet_2" {
  type = string
  description = "Subnets in which to deploy the RDS Mysql clusters."
}

variable "rds_subnet_3" {
  type = string
  description = "Subnets in which to deploy the RDS Mysql clusters."
}

variable "rds_engine_version" {
  type = string
  description = "RDS Mysql engine version."
}

variable "rds_major_engine_version" {
  type = string
  description = "RDS Mysql major engine version."
}

variable "rds_engine_family" {
  type = string
  description = "RDS Mysql engine family."
}

variable "rds_instance_type" {
  type = string
  description = "RDS Mysql cluster instance type."
}

variable "rds_disk_size" {
  type = number
  description = "Disk size for RDS Mysql cluster instances in GB."
}

variable "create_db_replica" {
  type = bool
  description = "Create a mysql DB replica or not."
}

variable "db_instance_user" {
  type = string
  description = "Mysql DB instance username."
}

variable "db_instance_user_password" {
  type = string
  description = "Mysql DB instance username."
}

variable "db_multi_az_enable" {
  type = bool
  description = "Enable Multi-AZ deployment for RDS Cluster."
}

variable "db_deletion_protection" {
  type = bool
  description = "Enable deletion protection mySQL db instance."
}

variable "db_delete_automated_backups" {
  type = bool
}

variable "db_publicly_accessible" {
  type = bool
  description = "Enable or disable public accessibility for mySQL db instance."
  default     = false
}

variable "db_skip_final_snapshot" {
  type = bool
  description = "create or skip fina snapshot creation for mySQL db instance."
}

variable "db_performance_insights_enabled" {
  description = "Enable performance monitoring insights for mySQL db instance."
  type        = bool
}

variable "db_kms_key_id" {
  type = string
  description = "KMS key id to encrypt data in mySQL db instance."
}

variable "db_backup_retention_period" {
  type = number
  description = "How long in days to retain backups."
}
