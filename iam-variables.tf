# ---------------------------------------------------------------------------------------------------------------------
# Resource naming
# ---------------------------------------------------------------------------------------------------------------------
variable "unique_prefix" {
  type        = string
  description = "Unique prefix with four characters"
}

variable "break_glass_username_list" {
  type        = list(string)
  default     = ["test_user_1", "test_user_2"]
}
