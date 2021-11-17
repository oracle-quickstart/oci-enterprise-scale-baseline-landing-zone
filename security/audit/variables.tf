variable "tenancy_ocid" {

}

variable "audit_log_bucket_name" {
  type = string
  default = "Audit_Log_Bucket"
}

variable "audit_retention_period" {
  type        = number
  description = "Audit Retention Period"
  default     = 365
}

variable "parent_compartment_ocid" {
  type        = string
  description = "the parent compartment ocid"
}

variable "service_connector_display_name" {
  type        = string
  description = "Service connector display name"
  default     = "audit_log_service_connector"
}
variable "service_connector_target_kind" {
  type        = string
  description = "Service connector target kind"
  default     = "objectStorage"
}

variable "service_connector_source_kind" {
  type        = string
  description = "Service connector source kind"
  default     = "logging"
}

variable "retention_rule_duration_time_amount" {
  type    = number
  default = 365
}

variable "retention_rule_duration_time_unit" {
  type    = string
  default = "DAYS"
}
variable "service_connector_description" {
  type    = string
  default = "Audit log service connector"
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

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}

