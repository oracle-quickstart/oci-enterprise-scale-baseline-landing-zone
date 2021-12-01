# ---------------------------------------------------------------------------------------------------------------------
# Required Variables
# ---------------------------------------------------------------------------------------------------------------------
variable "tenancy_ocid" {
  type        = string
  description = "The OCID for the tenancy"
}

variable "security_compartment_ocid" {
  type        = string
  description = "The security compartment OCID"
}

variable "network_compartment_ocid" {
  type        = string
  description = "The network compartment OCID"
}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}

variable "subnet_map" {
  type = map(string)
  description = ""
}

# ---------------------------------------------------------------------------------------------------------------------
#  Log Group Variables
# ---------------------------------------------------------------------------------------------------------------------
variable "log_group_display_name" {
  type        = string
  default     = "central_logging_group"
  description = "Central Logging Group for VCN flow logs"
}

# ---------------------------------------------------------------------------------------------------------------------
#  VCN Flow Log Variables
# ---------------------------------------------------------------------------------------------------------------------
variable "log_display_name" {
  type        = string
  default     = "vcn_flow_logs"
  description = "VCN Flow Logs display name"
}

variable "log_log_type" {
  type        = string
  description = "The type of the Log"
  default     = "SERVICE"
}

variable "log_configuration_source_category" {
  type        = string
  description = "The configuration source for the log"
  default     = "all"
}

variable "log_configuration_source_service" {
  type        = string
  description = "The configuration source service for the log"
  default     = "flowlogs"
}

variable "log_configuration_source_source_type" {
  type        = string
  description = "The configuration source type for the log"
  default     = "OCISERVICE"
}

variable "is_flow_log_enabled" {
  type        = string
  description = "Enable flow log on the subnets"
}

variable "log_retention_duration" {
  type        = number
  description = "The duration period of the log rentention"
  default     = 30
}

# ---------------------------------------------------------------------------------------------------------------------
# Variables for Service Connector
# ---------------------------------------------------------------------------------------------------------------------
variable "log_analytics_policy_name" {
  type        = string
  description = "Policy Name for the log analytics policy"
  default     = "OCI-LZ-LogAnalyticsPolicy"
}

variable "service_connector_display_name" {
  type        = string
  description = "The display name of Service connector"
  default     = "audit_log_service_connector"
}

variable "service_connector_source_kind" {
  type        = string
  description = "Service connector source kind"
  default     = "logging"
}

variable "service_connector_target_kind" {
  type        = string
  description = "Service connector target kind"
  default     = "loggingAnalytics"
}

variable "service_connector_target_batch_rollover_size_in_mbs" {
  type        = string
  description = "Service connector target batch rollover size in mbs"
  default     = 1
}

variable "service_connector_target_batch_rollover_time_in_ms" {
  type        = string
  description = "Service connector target batch rollover time in ms"
  default     = 420000
}
