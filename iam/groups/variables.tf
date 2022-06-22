variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

# ---------------------------------------------------------------------------------------------------------------------
# Optional suffix string to prevent naming collision with tenancy level resources
# ---------------------------------------------------------------------------------------------------------------------
variable "suffix" {
  type        = string
  description = "Optional suffix string used in a resource name"
}

# -----------------------------------------------------------------------------
# IAM Group Name Variables
# -----------------------------------------------------------------------------
variable "network_admin_group_name" {
  type        = string
  description = "The name for the network administrator group name"
}

variable "security_admins_group_name" {
  type        = string
  description = "The name of the security admin group"
}

variable "iam_admin_group_name" {
  type        = string
  description = "The name for the IAM Admin group"
}

variable "platform_admin_group_name" {
  type        = string
  description = "The name for the Platform Admin group"
}

variable "ops_admin_group_name" {
  type        = string
  description = "The name for the Ops Admin group"
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
