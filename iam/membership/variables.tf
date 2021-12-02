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
variable "break_glass_user_list" {
  type        = map(map(string))
  description = "The list break glass admin users"
}
