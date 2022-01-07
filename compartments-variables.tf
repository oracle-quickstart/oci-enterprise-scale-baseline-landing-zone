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

variable "workload_compartment_names" {
  type        = list(string)
  description = "List of application workload compartment names (maximum of five)"
  validation {
    condition     = alltrue([for i in var.workload_compartment_names: can(regex("^([\\w\\.-]){1,100}$", i))])
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique within its parent compartment."
  }
  validation {
    condition     = length(var.workload_compartment_names) < 6
    error_message = "A max of 5 workoad related entries are supported."
  }
}

# -----------------------------------------------------------------------------
# Compartment specific variables - Optional
# -----------------------------------------------------------------------------

variable "network_compartment_name" {
  type        = string
  description = "Name of the top level network compartment"
  default     = "network"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.network_compartment_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique within its parent compartment."
  }
}

variable "security_compartment_name" {
  type        = string
  description = "Name of the top level security compartment"
  default     = "security"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.security_compartment_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique within its parent compartment."
  }
}

variable "common_infra_compartment_name" {
  type        = string
  description = "Name of the common infrastructure compartment"
  default     = "common-infra"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.common_infra_compartment_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique within its parent compartment."
  }
}

variable "applications_compartment_name" {
  type        = string
  description = "Name of the top level application compartment"
  default     = "applications"
  validation {
    condition     = can(regex("^([\\w\\.-]){1,100}$", var.applications_compartment_name))
    error_message = "Allowed maximum 100 characters, including letters, numbers, periods, hyphens, underscores, and is unique within its parent compartment."
  }
}