# ---------------------------------------------------------------------------------------------------------------------
# Resource naming
# ---------------------------------------------------------------------------------------------------------------------
variable "key_id" {
  type        = string
  description = "Encryption key OCID for security admin policy"
  default     = "PLACEHOLDER"
}

variable "vault_id" {
  type        = string
  description = "Vault OCID for security admin policy"
  default     = "PLACEHOLDER"
}

variable "break_glass_user_email_list" {
  type        = list(string)
  description = "Unique list of break glass user email addresses that do not exist in the tenancy"
  default     = []
  validation {
    condition     = alltrue([for i in var.break_glass_user_email_list: can(regex("^[^\s@]+@([^\s@.,]+\.)+[^\s@.,]{2,}$", i))])
    error_message = "Error. Must be a list of valid email addresses."
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group Names
# ---------------------------------------------------------------------------------------------------------------------
variable "administrator_group_name" {
  type        = string
  description = "The name for the administrator group"
  default     = "Administrators"
}

variable "network_admin_group_name" {
  type        = string
  description = "The name for the network administrator group name"
  default     = "Virtual-Network-Admins"
}

variable "lb_users_group_name" {
  type        = string
  description = "The name for the load balancer users group name"
  default     = "LBUsers"
}

variable "workload_storage_admins_group_name" {
  type        = string
  description = "The name for the workload storage administrators group"
  default     = "Workload-Storage-Admins"
}

variable "workload_storage_users_group_name" {
  type        = string
  description = "The name for the workload storage users group"
  default     = "Workload-Storage-Users"
}

variable "workload_admins_group_name" {
  type        = string
  description = "The name for the workload administrators group"
  default     = "Workload-Admins"
}

variable "workload_users_group_name" {
  type        = string
  description = "The name for the workload users group"
  default     = "Workload-Users"
}

variable "security_admins_group_name" {
  type        = string
  description = "The name of the security admin group"
  default     = "SecurityAdmins"
}

variable "cloud_guard_operators_group_name" {
  type        = string
  description = "The name for the Cloud Guard Operator group name"
  default     = "CloudGuard-Operator"
}

variable "cloud_guard_analysts_group_name" {
  type        = string
  description = "The name of the Cloud Guard Analyst group"
  default     = "CloudGuard-Analyst"
}

variable "cloud_guard_architects_group_name" {
  type        = string
  description = "The name for the Cloud Guard Architect group name"
  default     = "CloudGuard-Architect"
}