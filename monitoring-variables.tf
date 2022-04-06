variable "security_topic_name" {
  type        = string
  description = "The name of security topic"
  default     = "security-topic"
}

variable "network_topic_name" {
  type        = string
  description = "The name of network topic"
  default     = "network-topic"
}

variable "budget_topic_name" {
  type        = string
  description = "The name of budget topic"
  default     = "budget-topic"
}
