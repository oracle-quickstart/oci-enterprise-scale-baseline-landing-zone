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
variable "user_id" {
  type        = string
  description = "The user OCID of the break glass admin user"
}
