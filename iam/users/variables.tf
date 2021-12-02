variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "break_glass_user_email_list" {
  type        = list(string)
  description = "List of break glass user email addresses"
}

# -----------------------------------------------------------------------------
# Tag Variables
# -----------------------------------------------------------------------------
variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}

