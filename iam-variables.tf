# ---------------------------------------------------------------------------------------------------------------------
# Resource naming
# ---------------------------------------------------------------------------------------------------------------------
variable "key_id" {
  type        = string
  description = "Encryption key OCID for security admin policy and audit bucket"
  default     = "PLACEHOLDER"
}

variable "vault_id" {
  type        = string
  description = "Vault OCID for security admin policy"
  default     = "PLACEHOLDER"
}

variable "break_glass_user_email_list" {
  type        = list(string)
  description = "Unique list of break glass user email addresses that do not exist in the tenancy. These users are added to the Administrator group."
  default     = []
  validation {
    condition     = alltrue([for i in var.break_glass_user_email_list : can(regex("^[^\\s@]+@([^\\s@\\.,]+.)+[^\\s@\\.,]{2,}$", i))])
    error_message = "Must be a list of valid email addresses."
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM Group Names
# ---------------------------------------------------------------------------------------------------------------------
variable "administrator_group_name" {
  type        = string
  description = "The name for the administrator group"
  default     = "Administrators"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.administrator_group_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique across all groups."
  }
}

variable "network_admin_group_name" {
  type        = string
  description = "The name for the network administrator group name"
  default     = "Virtual-Network-Admins"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.network_admin_group_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique across all groups."
  }
}

variable "lb_users_group_name" {
  type        = string
  description = "The name for the load balancer users group name"
  default     = "LB-Users"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.lb_users_group_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique across all groups."
  }
}

variable "security_admins_group_name" {
  type        = string
  description = "The name of the security admin group"
  default     = "Security-Admins"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.security_admins_group_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique across all groups."
  }
}

variable "cloud_guard_operators_group_name" {
  type        = string
  description = "The name for the Cloud Guard Operator group name"
  default     = "CloudGuard-Operator"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.cloud_guard_operators_group_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique across all groups."
  }
}

variable "cloud_guard_analysts_group_name" {
  type        = string
  description = "The name of the Cloud Guard Analyst group"
  default     = "CloudGuard-Analyst"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.cloud_guard_analysts_group_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique across all groups."
  }
}

variable "cloud_guard_architects_group_name" {
  type        = string
  description = "The name for the Cloud Guard Architect group name"
  default     = "CloudGuard-Architect"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.cloud_guard_architects_group_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique across all groups."
  }
}
