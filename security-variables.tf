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

variable "configuration_detector_recipe_display_name" {
  type        = string
  description = "display name for configuration detector recipe"
  default     = "OCI Configuration Detector Recipe"
}

variable "activity_detector_recipe_display_name" {
  type        = string
  description = "display name for activity detector recipe"
  default     = "OCI Activity Detector Recipe"
}

variable "vulnerability_scanning_service_policy_name" {
 type        = string
 description = "Name of Scanning Service Policy"
 default     = "OCI-LZ-Scanning-Service-Policy"
}

# -----------------------------------------------------------------------------
# Bastion Related Variables
# -----------------------------------------------------------------------------
variable "bastion_subnet_cidr_block" {
  type        = string
  description = "CIDR Block for bastion subnet"
}

variable "bastion_type" {
  type        = string
  description = "the type of bastion service"
  default     = "standard"
}

variable "bastion_client_cidr_block_allow_list" {
  type        = list(string)
  description = "A list of address ranges in CIDR notation that bastion is allowed to connect"
}

variable "bastion_max_session_ttl_in_seconds" {
  type        = number
  description = "The maximum amount of time that bastion session can remain active"
  default     = 1800
}