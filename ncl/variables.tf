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
  default     = "<%=customOptions.awsVPCId%>"
}

variable "aws_region" {
  type = string
  description = "AWS region to deploy RDS Mysql cluster and resources."
  default     = "<%=customOptions.awsRegion%>"
}

variable "project_name" {
  type = string
  description = "Name to prefix RDS Mysql cluster and resources."
  default     = "<%=instance.name%>"
  // default     = "morpheus-rds"
}

variable "owner" {
  type = string
  description = "Project Owner."
  default     = "<%=customOptions.Owner%>"
}

variable "environment" {
  type = string
  description = "Project Environment."
  default     = "<%=customOptions.AWSEnvironments%>"
}

variable "cost_center" {
  type = string
  description = "Project Cost Center"
  default     = "<%=customOptions.awsCostCenter%>"
}

# rds vars
variable "rds_subnet_1" {
  type = string
  description = "Subnets in which to deploy the RDS Mysql clusters."
  default     = "<%=customOptions.awsSubnet1%>"
}

variable "rds_subnet_2" {
  type = string
  description = "Subnets in which to deploy the RDS Mysql clusters."
  default     = "<%=customOptions.awsSubnet2%>"
}

variable "rds_subnet_3" {
  type = string
  description = "Subnets in which to deploy the RDS Mysql clusters."
  default     = "<%=customOptions.awsSubnet3%>"
}

variable "rds_engine_version" {
  type = string
  description = "RDS Mysql engine version."
  default     = "<%=customOptions.mySQLEngineVersion%>"
}

variable "rds_major_engine_version" {
  type = string
  description = "RDS Mysql major engine version."
  default     = "<%=customOptions.mySQLMajorEngineVersion%>"
}

variable "rds_engine_family" {
  type = string
  description = "RDS Mysql engine family."
  default     = "<%=customOptions.mySQLEngineFamily%>"
}

variable "rds_instance_type" {
  type = string
  description = "RDS Mysql cluster instance type."
  default     = "<%=customOptions.awsRDSInstanceType%>"
}

variable "rds_disk_size" {
  type = number
  description = "Disk size for RDS Mysql cluster instances in GB."
  default     = "<%=customOptions.instanceDiskSize%>"
}

variable "create_db_replica" {
  type = bool
  description = "Create a mysql DB replica or not."
  default     = "<%=customOptions.mySQLdbCreateReplica%>"
}

variable "db_instance_user" {
  type = string
  description = "Mysql DB instance username."
  default     = "<%=customOptions.awsRDSDBUsername%>"
}

variable "db_instance_user_password" {
  type = string
  description = "Mysql DB instance username."
  default     = "<%=customOptions.awsRDSDBUserPassword%>"
}

variable "db_multi_az_enable" {
  type = bool
  description = "Enable Multi-AZ deployment for RDS Cluster."
  default     = "<%=customOptions.awsRDSEnableMultiAZ%>"
}

variable "db_deletion_protection" {
  type = bool
  description = "Enable deletion protection mySQL db instance."
  default     = "<%=customOptions.mySQLDeletionProtection%>"
  // default     = false
}

variable "db_delete_automated_backups" {
  type = bool
  description = "Delete automated backups for mySQL db instance."
  default     = "<%=customOptions.mySQLDeleteAutomatedBackups%>"
}

variable "db_publicly_accessible" {
  type = bool
  description = "Enable or disable public accessibility for mySQL db instance."
  default     = false
}

variable "db_skip_final_snapshot" {
  type = bool
  description = "create or skip fina snapshot creation for mySQL db instance."
  default     = "<%=customOptions.mySQLDBSkipFinalSnapShot%>"
}

variable "db_performance_insights_enabled" {
  description = "Enable performance monitoring insights for mySQL db instance."
  type        = bool
  default     = "<%=customOptions.mySQLDBEnablePerformanceInsights%>"
}

variable "db_kms_key_id" {
  type = string
  description = "KMS key id to encrypt data in mySQL db instance."
  default     = "<%=customOptions.awsKMSKey%>"
}

variable "db_backup_retention_period" {
  type = number
  description = "How long in days to retain backups."
  default     = "<%=customOptions.mySQLBackupRetention%>"
}
