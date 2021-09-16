provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {
}

data "aws_vpc" "selected" {
  id = "vpc-f723508d"
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.selected.id
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = "OCS-Test"
  }
}

resource "aws_s3_bucket" "msk_bucket" {
  bucket = "${var.cluster_name}-logs-bucket"
  acl           = "private"
  force_destroy = true

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "msk_log_group" {
  name = "${var.cluster_name}-loggroups"

  tags = var.tags
}


module "msk_cluster" {
  source = "../modules/aws-msk-cluster"

  vpc_id = data.aws_vpc.selected.id
  cluster_name    = var.cluster_name
  instance_type   = var.instance_type
  number_of_nodes = length(data.aws_subnet_ids.private.ids)
  client_subnets  = data.aws_subnet_ids.private.ids
  kafka_version   = var.kafka_version
  volume_size     = var.volume_size

  s3_logs_bucket = aws_s3_bucket.msk_bucket.id
  s3_logs_prefix = "${var.cluster_name}-msk"

  cloudwatch_logs_group = aws_cloudwatch_log_group.msk_log_group.name

  server_properties = {
    "auto.create.topics.enable"  = "true"
    "default.replication.factor" = "1"
    "num.partitions"= "1"
    "log.retention.hours"= "24"
  }

  encryption_in_transit_client_broker = "TLS"
  enhanced_monitoring                 = "PER_BROKER"

  tags = var.tags
}
