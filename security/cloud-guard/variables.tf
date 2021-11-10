variable "parent_compartment_ocid" {
  type        = string
  description = "the parent compartment ocid"
}

variable "region" {
  type        = string
  description = "the OCI region"
}

variable "cloud_guard_configuration_status" {
  type        = string
  description = "the status of the Cloud Guard tenant"
}

variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "configuration_detector_recipe_display_name" {
  type = string
  description = "display name for configuration detector recipe"
}

variable "activity_detector_recipe_display_name" {
  type = string
  description = "display name for activity detector recipe"
}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}

variable "cloud_guard_policy_name" {
  type        = string
  description = "Name of Cloud Guard Policy"
  default     = "OCI-LZ-Cloud-Guard-Policy"
}

variable "cloud_guard_target_name" {
  type        = string
  description = "Name of Cloud Guard Policy"
  default     = "OCI-LZ-Cloud-Guard-Target"
}

variable "target_resource_type" {
  type        = string
  description = "Cloud Guard target resource type"
  default     = "COMPARTMENT"
}

variable "target_description" {
  type        = string
  description = "Cloud Guard target description"
  default     = "Landing Zones Parent compartment"
}

variable "vulnerability_scanning_service_policy_name" {
 type        = string
 description = "Name of Scanning Service Policy"
 default     = "OCI-LZ-Scanning-Service-Policy"
}

variable "parent_compartment_name" {
  type        = string
  description = "Name of the top level / parent compartment"
}
