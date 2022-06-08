# -----------------------------------------------------------------------------
# IAM Group Name Variables
# -----------------------------------------------------------------------------
variable "administrator_group_name" {
  type        = string
  description = "The name for the administrator group"
}

# -----------------------------------------------------------------------------
# Break Glass User Variable
# -----------------------------------------------------------------------------
variable "user_id" {
  type        = string
  description = "The user OCID of the break glass admin user"
}

variable "tenancy_ocid" {
  type        = string
  description = "The OCID for the tenancy"
}
