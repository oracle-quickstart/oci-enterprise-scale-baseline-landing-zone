# -----------------------------------------------------------------------------
# Required Variable
# -----------------------------------------------------------------------------
variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

# -----------------------------------------------------------------------------
# IAM Group OCID Variable
# -----------------------------------------------------------------------------
variable "administrator_group_id" {
  type        = string
  description = "The OCID for the administrator group"
}

# -----------------------------------------------------------------------------
# Break Glass User Variable
# -----------------------------------------------------------------------------
variable "break_glass_username_list" {
  type        = list(string)
  description = "The list break glass admin users"
}
