# -----------------------------------------------------------------------------
# Required inputs
# -----------------------------------------------------------------------------
variable "compartment_name" {
  type        = string
  description = "Name of the compartment to create"
  default     = "Parent_Compartment"
}

variable "tenancy_ocid" {
  type        = string
  description = "root-level / tenancy OCID"
  default     = "ocid1.tenancy.oc1..aaaaaaaaxbchsnzhdxyoewmoqiqzvltba2ri7gijhbd2z5ybpgorv7yhxeeq"
}

variable "tag_cost_center" {
  type        = string
  description = "CostCenter tag value"
  default     = "example_tag_cost_center"
}

variable "tag_geo_location" {
  type        = string
  description = "GeoLocation tag value"
  default     = "example_tag_geo_location"
}

variable "compartment_delete_enabled" {
  type        = bool
  description = "Compartment delete would be enabled in Sandbox mode"
  default     = "true"
}

# ---------------------------------------------------------------------------------------------------------------------
# Optional suffix string to prevent naming collision with tenancy level resources
# ---------------------------------------------------------------------------------------------------------------------
variable "suffix" {
  type        = string
  description = "Optional suffix string used in a resource name"
  default     = "_test_sandbox"
}