# -----------------------------------------------------------------------------
# Required inputs
# -----------------------------------------------------------------------------
variable "applications_compartment_ocid" {
  type        = string
  description = "The OCID of the applications compartment"
}

variable "compartment_name" {
  type        = string
  description = "The name of the compartment"
}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}

variable "is_sandbox_mode_enabled" {
  type        = bool
  description = "Do you want to run the stack in Sandbox mode?"
}
