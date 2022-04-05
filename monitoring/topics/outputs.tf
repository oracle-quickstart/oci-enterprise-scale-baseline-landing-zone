
output "topics" {
  description = "The topcs, indexed by keys in var.topics."
  value       = { for k, v in var.topics : k => oci_ons_notification_topic.topics[k] }
} 
