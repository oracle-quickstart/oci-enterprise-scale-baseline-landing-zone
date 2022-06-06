# -----------------------------------------------------------------------------
# Compartment specific variables - Required
# -----------------------------------------------------------------------------
variable "parent_compartment_name" {
  type        = string
  description = "Name of the top level / parent compartment"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.parent_compartment_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique within its parent compartment."
  }
}

# -----------------------------------------------------------------------------
# Compartment specific variables - Optional
# -----------------------------------------------------------------------------

variable "network_compartment_name" {
  type        = string
  description = "Name of the top level network compartment"
  default     = "Network"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.network_compartment_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique within its parent compartment."
  }
}

variable "security_compartment_name" {
  type        = string
  description = "Name of the top level security compartment"
  default     = "Security"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.security_compartment_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique within its parent compartment."
  }
}

variable "common_infra_compartment_name" {
  type        = string
  description = "Name of the common infrastructure compartment"
  default     = "Common-Infra"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.common_infra_compartment_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique within its parent compartment."
  }
}

variable "applications_compartment_name" {
  type        = string
  description = "Name of the top level application compartment"
  default     = "Applications"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.applications_compartment_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique within its parent compartment."
  }
}
