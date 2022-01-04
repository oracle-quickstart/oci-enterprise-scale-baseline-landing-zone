variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "break_glass_user_index" {
  type        = string
  description = "the index of the break glass user"
}

variable "break_glass_user_email" {
  type        = string
  description = "The email address of the break glass user"
}

# ---------------------------------------------------------------------------------------------------------------------
# Optional suffix string to prevent naming collision with tenancy level resources
# ---------------------------------------------------------------------------------------------------------------------
variable "suffix" {
  type        = string
  description = "Random unique string used in suffix name"
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

