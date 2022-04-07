# ---------------------------------------------------------------------------------------------------------------------
# Optional suffix string to prevent naming collision with tenancy level resources
# ---------------------------------------------------------------------------------------------------------------------
variable "suffix" {
  type        = string
  description = "Optional suffix string used in a resource name"
}

# -----------------------------------------------------------------------------
# Common Variables
# -----------------------------------------------------------------------------
variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "parent_compartment_ocid" {
  type        = string
  description = "the parent compartment ocid"
}

variable "security_compartment_ocid" {
  type        = string
  description = "Security compartment ocid"
}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}

variable "vulnerability_scanning_service_policy_name" {
  type        = string
  description = "Name of Scanning Service Policy"
  default     = "OCI-LZ-Scanning-Service-Policy"
}

variable "parent_compartment_name" {
  type        = string
  description = "Name of the top level / parent compartment"
}

# -----------------------------------------------------------------------------
# VSS Host Scan Recipe Variables
# -----------------------------------------------------------------------------
variable "host_scan_recipe_display_name" {
  type        = string
  description = "Vulnerability scanning service display name"
  default     = "OCI-LZ-Scanning-Service-Recipe"
}

variable "host_scan_recipe_agent_settings_scan_level" {
  type        = string
  description = "Vulnerability scanning service agent scan level"
}

variable "host_scan_recipe_agent_settings_agent_configuration_vendor" {
  type        = string
  description = "Vulnerability scanning service agent vendor"
  default     = "OCI"
}

variable "host_scan_recipe_port_settings_scan_level" {
  type        = string
  description = "Vulnerability scanning service port scan level"
}

variable "vss_scan_schedule" {
  type        = string
  description = "Vulnerability scanning service scan schedule"
}

# -----------------------------------------------------------------------------
# VSS Host Scan Target Variables
# -----------------------------------------------------------------------------
variable "host_scan_target_display_name" {
  type        = string
  description = "Vulnerability scanning service target display name"
  default     = "OCI-LZ-Scanning-Service-Target"
}

variable "host_scan_target_description" {
  type        = string
  description = "Vulnerability scanning service target description"
  default     = "Vulnerability scanning service scan target"
}

variable "agent_cis_benchmark_settings_scan_level" {
  type        = string
  description = "Agent benchmarking settings scan level"
}
