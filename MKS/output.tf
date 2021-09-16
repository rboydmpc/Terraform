output "bootstrap_brokers_tls" {
  description = "A comma separated list of one or more hostname:port pairs of kafka brokers suitable to boostrap connectivity to the kafka cluster."
  value       = module.msk_cluster.bootstrap_brokers_tls
}

output "zookeeper_connect_string" {
  description = "A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster."
  value       = module.msk_cluster.zookeeper_connect_string
}

output "default_security_group" {
  description = "Msk cluster default security group id."
  value       = module.msk_cluster.default_security_group
}
