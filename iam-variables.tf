# ---------------------------------------------------------------------------------------------------------------------
# Resource naming
# ---------------------------------------------------------------------------------------------------------------------
variable "key_id" {
  type        = string
  description = "Encryption key OCID for security admin policy"
}

variable "vault_id" {
  type        = string
  description = "Vault OCID for security admin policy"
}

variable "break_glass_user_email_list" {
  type        = list(string)
  description = "Unique list of break glass user email addresses that do not exist in the tenancy"
   default    = []
}