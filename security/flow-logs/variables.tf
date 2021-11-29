# ---------------------------------------------------------------------------------------------------------------------
# 
# ---------------------------------------------------------------------------------------------------------------------
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
  description = "Central Logging Group display name"
}

variable "log_display_name" {
  type        = string
  default     = "vcn_flow_logs"
  description = "VCN Flow Logs display name"
}

variable "log_log_type" {
  type    = string
  default = "service"
}

variable "log_configuration_source_category" {
  type    = string
  default = "Flow Logs"
}

variable "log_configuration_source_resource" {
  type    = string
}

variable "log_configuration_source_service" {
  type    = string
  default = "Virtual Cloud Network"
}

variable "log_configuration_source_source_type" {
  type    = string
  default = "OCISERVICE"
}

# variable "log_is_enabled" {
#   type    = string
#   default = ""
# }

# variable "log_retention_duration" {
#     type = string
#     default = ""
# }