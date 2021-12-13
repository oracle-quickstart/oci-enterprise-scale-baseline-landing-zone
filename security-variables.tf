# -----------------------------------------------------------------------------
# Cloud Guard Related Variables
# -----------------------------------------------------------------------------
variable "cloud_guard_configuration_status" {
  type        = string
  description = "the status of the Cloud Guard tenant (ENABLED or DISABLED)"
  validation {
    condition     = var.cloud_guard_configuration_status == "ENABLED" || var.cloud_guard_configuration_status == "DISABLED"
    error_message = "Please enter ENABLED or DISABLED for the status of the Cloud Guard Configuration."
  }
}

variable "host_scan_recipe_agent_settings_agent_configuration_vendor" {
  type        = string
  description = "Vulnerability scanning service agent vendor"
  default     = "OCI"
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
}

variable "bastion_client_cidr_block_allow_list" {
  type        = list(string)
  description = "A list of address ranges in CIDR notation that bastion is allowed to connect"
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
