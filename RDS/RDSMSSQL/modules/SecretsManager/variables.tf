variable "soc_region" {
  description = "Region for the SOC account (to create the Secret)"
  type        = string 
  default = "us-gov-west-1"
}

variable "soc_access_key"{
  description = "Access Key for the SOC account (to create the Secret)"
  type        = string 
}

variable "soc_secret_key" {
  description = "Secret Key for the SOC account (to create the Secret)"
  type        = string 
}

variable "secret_name" { 
  description = "Leave blank. The system will automatically popuplate this field."
  type        = string
  default     = ""
}

variable "secret_cmk_id" {
}

variable "cicd_role_arn"{
}

variable "secret_value_dbname" {
    type =  string
    default = "placeholder"
}

variable "secret_value_dbendpoint" {
    type    = string
    default = "placeholder"
}

variable "secret_value_dbarn" {
    type    = string
    default = "placeholder"
}

variable "secret_value_dbusername" {
    type    = string
    default = "placeholder"
}

variable "secret_value_dbpassword" {
    type    = string
    default = "placeholder"
}

variable "account_name" {
    type    = string
    default = "placeholder"
}

variable "engine_name" {
    type    = string
    #default = "placeholder"
}
variable "db_port" {
    type    = string
    default = "placeholder"
}
