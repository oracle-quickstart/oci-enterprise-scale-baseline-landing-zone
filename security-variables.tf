# -----------------------------------------------------------------------------
# Cloud Guard Related Variables
# -----------------------------------------------------------------------------
variable "is_cloud_guard_enabled" {
  type        = bool
  description = "the status of the Cloud Guard tenant (ENABLED if true or DISABLED if false)"
  default     = true
}

variable "is_vulnerability_scanning_service_enabled" {
  type        = bool
  description = "the status of the vulnerability scanning service"
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
  default = ""
}

variable "bastion_client_cidr_block_allow_list" {
  type        = list(string)
  description = "A list of address ranges in CIDR notation that bastion is allowed to connect"
  default = []
}

# -----------------------------------------------------------------------------
# Audit Logging Variables
# -----------------------------------------------------------------------------
variable "retention_rule_duration_time_amount" {
  type        = string
  description = <<EOF
        “Please note this feature is irreversible after 14 days.
        Please review (and/or) unlock the retention rule before it is locked permanently.
        By enabling this feature, logs will be archived in an immutable storage with locked retention rule avoiding object modification and deletion.
        After the rule is locked, only increase in the retention is allowed”
      EOF
  default     = 1

  validation {
    condition     = var.retention_rule_duration_time_amount >= 1
    error_message = "The amount of retention rule time duration should be 1 days or greater."
  }
}

# -----------------------------------------------------------------------------
# VCN Flow Log Variables
# -----------------------------------------------------------------------------
variable "advanced_logging_option" {
  type        = string
  description = "Enable or Disable VCN flow logs and/or Audit Logs. Select an option between NONE, AUDIT_LOGS, FLOW_LOGS or BOTH."
  validation {
    condition     = can(regex("\\b(?:AUDIT_LOGS|FLOW_LOGS|BOTH|NONE)\\b", var.advanced_logging_option))
    error_message = "Select an option between NONE, AUDIT_LOGS, FLOW_LOGS or BOTH."
  }
  default = "BOTH"
}
