# -----------------------------------------------------------------------------
# Required inputs
# -----------------------------------------------------------------------------
variable "compartment_name" {
  type        = string
  description = "Name of the compartment to create"
}

variable "tenancy_ocid" {
  type        = string
  description = "root-level / tenancy OCID"
}

variable "tag_cost_center" {
  type        = string
  description = "CostCenter tag value"
}

variable "tag_geo_location" {
  type        = string
  description = "GeoLocation tag value"
}