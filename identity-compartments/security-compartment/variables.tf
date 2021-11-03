# ---------------------------------------------------------------------------------------------------------------------
# Required inputs
# ---------------------------------------------------------------------------------------------------------------------
variable "common_infra_compartment_ocid" {
  type        = string
  description = "The OCID of the common infra compartment"
}

variable "compartment_name" {
  type        = string
  description = "The name of the compartment"
}

variable "tag_cost_center" {
  type       = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type = string
  description = "Geo location for OCI resources"
}