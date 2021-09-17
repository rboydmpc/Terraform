variable "access_key" {}
variable "secret_key" {}

variable "cluster_name" {
  description = "Name of the MSK cluster."
  type        = string
}

variable "kafka_version" {
  description = "Specify the desired Kafka software version."
  type        = string
}

// variable "number_of_nodes" {
//   description = "The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets."
//   type        = number
// }

variable "volume_size" {
  description = "The size in GiB of the EBS volume for the data drive on each broker node."
  type        = number
  default     = 10
}

variable "instance_type" {
  description = "Specify the instance type to use for the kafka brokers. e.g. kafka.m5.large."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}