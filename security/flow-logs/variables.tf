variable "tenancy_ocid" {
  type        = string
  description = "The OCID for the tenancy"
}

variable "security_compartment_ocid" {
  type        = string
  description = "The security compartment OCID"
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
# 
# ---------------------------------------------------------------------------------------------------------------------
variable "log_group_display_name" {
  type        = string
  default     = "central_logging_group"
  description = "Central Logging Group for VCN flow logs"
}

variable "log_display_name" {
  type        = string
  default     = "vcn_flow_logs"
  description = "VCN Flow Logs display name"
}

variable "log_log_type" {
  type    = string
  default = "SERVICE"
}

variable "log_configuration_source_category" {
  type    = string
  default = "all"
}

variable "log_configuration_source_resource" {
  type    = string
}

variable "log_configuration_source_service" {
  type    = string
  default = "flowlogs"
}

variable "log_configuration_source_source_type" {
  type    = string
  default = "OCISERVICE"
}

variable "is_flow_log_enabled" {
  type    = string
}

variable "log_retention_duration" {
    type = number
    default = 30
}