# ---------------------------------------------------------------------------------------------------------------------
# Resource naming
# ---------------------------------------------------------------------------------------------------------------------
variable "break_glass_username_list" {
  type        = list(string)
  description = "Break Glass Admin users list"
  default = []
}

variable "key_id" {
  type        = string
  description = "Encryption key OCID for security admin policy"
}

variable "vault_id" {
  type        = string
  description = "Vault OCID for security admin policy"
}
