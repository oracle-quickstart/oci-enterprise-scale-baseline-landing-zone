variable "tenancy_ocid" {

}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}

variable "parent_compartment_name" {
  type        = string
  description = "Name of the parent compartment"
}

variable "service_connector_policy_name" {
  type        = string
  description = "Policy Name for the service connector to access object storage bucket"
  default     = "OCI-LZ-ConnectorPolicy-objectStorage"
}

# ---------------------------------------------------------------------------------------------------------------------
# Variables for Object storage Bucket and Retention Rules
# ---------------------------------------------------------------------------------------------------------------------
variable "audit_log_bucket_name" {
  type = string
  default = "audit_log_bucket"
}

variable "audit_retention_period" {
  type        = number
  description = "Audit Retention Period"
  default     = 365
}

variable "parent_compartment_ocid" {
  type        = string
  description = "The parent compartment ocid"
}

variable "retention_rule_duration_time_amount" {
  type    = number
  default = 365
}

variable "retention_rule_duration_time_unit" {
  type    = string
  default = "DAYS"
}

# ---------------------------------------------------------------------------------------------------------------------
# Variables for Service Connector
# ---------------------------------------------------------------------------------------------------------------------
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
  default     = "objectStorage"
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

