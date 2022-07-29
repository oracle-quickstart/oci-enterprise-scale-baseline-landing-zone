# -----------------------------------------------------------------------------
# Required inputs
# -----------------------------------------------------------------------------
variable "compartment_name" {
  type        = string
  description = "Name of the compartment to create"
}

variable "tag_cost_center" {
  type        = string
  description = "CostCenter tag value"
}

variable "tag_geo_location" {
  type        = string
  description = "GeoLocation tag value"
}

variable "compartment_delete_enabled" {
  type        = bool
  description = "Compartment delete would be enabled in Sandbox mode"
}

# ---------------------------------------------------------------------------------------------------------------------
# Optional suffix string to prevent naming collision with tenancy level resources
# ---------------------------------------------------------------------------------------------------------------------
variable "suffix" {
  type        = string
  description = "Optional suffix string used in a resource name"
}
