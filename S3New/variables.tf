variable "access_key" {}

variable "secret_key" {}

variable "bucket_name" {}

variable "acl_value" {
    default = "private"
    description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)."
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)."
  type        = string
  #default     = "gp2"
}
