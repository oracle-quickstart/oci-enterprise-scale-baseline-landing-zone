variable "security_topic_name" {
  type        = string
  description = "The name of security topic"
}

variable "compartment_id" {
  type        = string
  description = "The OCID of security compartment"
}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}