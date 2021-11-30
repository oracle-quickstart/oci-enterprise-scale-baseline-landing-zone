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
  type = string
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

variable "vcn_id" {
  type        = string
  description = "The OCID of the primary VCN"
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
