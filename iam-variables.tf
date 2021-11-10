# ---------------------------------------------------------------------------------------------------------------------
# Resource naming
# ---------------------------------------------------------------------------------------------------------------------
variable "break_glass_username_list" {
  type        = list(string)
  description = "Break Glass Admin users list"
}

variable "key_id" {
  type        = string
  description = "Encryption key ocid for security admin policy"
}

variable "vault_id" {
  type        = string
  description = "Vault ocid for security admin policy"
}
