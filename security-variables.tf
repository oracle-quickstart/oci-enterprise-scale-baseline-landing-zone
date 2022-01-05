# -----------------------------------------------------------------------------
# Cloud Guard Related Variables
# -----------------------------------------------------------------------------
variable "is_cloud_guard_enabled" {
  type        = bool
  description = "the status of the Cloud Guard tenant (ENABLED if true or DISABLED if false)"
  default     = true
}

variable "host_scan_recipe_agent_settings_scan_level" {
  type        = string
  description = "Vulnerability scanning service agent scan level"
  default     = "STANDARD"
}

variable "host_scan_recipe_port_settings_scan_level" {
  type        = string
  description = "Vulnerability scanning service port scan level"
  default     = "STANDARD"
}

variable "agent_cis_benchmark_settings_scan_level" {
  type        = string
  description = "Agent bechamrking settings scan level"
  default     = "STRICT"
}

variable "vss_scan_schedule" {
  type        = string
  description = "Vulnerability scanning service scan schedule"
  default     = "DAILY"
}

# -----------------------------------------------------------------------------
# Bastion Related Variables
# -----------------------------------------------------------------------------
variable "bastion_subnet_cidr_block" {
  type        = string
  description = "CIDR Block for bastion subnet"
  validation {
    condition     = can(regex("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/([0-9]|[1][0-9]|[2][0-9]))$", var.bastion_subnet_cidr_block))
    error_message = "Must be a valid address range in CIDR notation that bastion is allowed to connect."
  }
}

variable "bastion_client_cidr_block_allow_list" {
  type        = list(string)
  description = "A list of address ranges in CIDR notation that bastion is allowed to connect"
  validation {
    condition     = alltrue([for i in var.bastion_client_cidr_block_allow_list: can(regex("^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]).){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(/([0-9]|[1][0-9]|[2][0-9]))$", i))])
    error_message = "Must be a valid list of address ranges in CIDR notation that bastion is allowed to connect."
  }
}

# -----------------------------------------------------------------------------
# Audit Logging Variables
# -----------------------------------------------------------------------------
variable "retention_rule_duration_time_amount" {
  type        = string
  description = "Amount of retention rule duration time in days"
  default     = 365

  validation {
    condition     = var.retention_rule_duration_time_amount >= 365
    error_message = "The amount of retention rule time duration should be 365 days or greater."
  }
}

# -----------------------------------------------------------------------------
# VCN Flow Log Variables
# -----------------------------------------------------------------------------
variable "advanced_logging_option" {
  type        = string
  description = "Enable or Disable VCN flow logs and/or Audit Logs"
  validation {
    condition     = can(regex("\b(?:AUDIT_LOGS|FLOW_LOGS|BOTH|NONE)\b", var.advanced_logging_option))
    error_message = "Select an option between NONE, AUDIT_LOGS, FLOW_LOGS or BOTH."
  }

}
