# -----------------------------------------------------------------------------
# Required inputs
# -----------------------------------------------------------------------------
variable "parent_compartment_ocid" {
  type        = string
  description = "The OCID of the parent compartment"
  default     = ""
}

variable "compartment_name" {
  type        = string
  description = "The name of the compartment"
  default     = "Applications_Compartment_test_sandbox"
}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
  default     = "example_tag_cost_center"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
  default     = "example_tag_geo_location"
}

variable "compartment_delete_enabled" {
  type        = bool
  description = "Compartment delete would be enabled in Sandbox mode"
  default     = "true"
}
