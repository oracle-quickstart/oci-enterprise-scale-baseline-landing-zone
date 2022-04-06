variable "compartment_id" {
  type        = string
  description = "The compartment ocid where security subscription lives on"
}

variable "subscription_protocol" {
  type        = string
  description = "The protocol used for the subscription"
}

variable "topic_id" {
  type        = string
  description = "The OCID of the topic for the subscription"
}

variable "endpoint" {
  type        = string
  description = "Email address for all security related notifications"
}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}