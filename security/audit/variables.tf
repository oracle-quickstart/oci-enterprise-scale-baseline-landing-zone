variable "tenancy_ocid" {
  type        = string
  description = "The OCID for the tenancy"
}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}

variable "parent_compartment_ocid" {
  type        = string
  description = "The parent compartment OCID"
}

variable "parent_compartment_name" {
  type        = string
  description = "Name of the parent compartment"
}

variable "security_compartment_ocid" {
  type        = string
  description = "The security compartment OCID"
}

variable "security_compartment_name" {
  type        = string
  description = "Name of the security compartment"
}

# ---------------------------------------------------------------------------------------------------------------------
# Optional suffix string to prevent naming collision with tenancy level resources
# ---------------------------------------------------------------------------------------------------------------------
variable "suffix" {
  type        = string
  description = "Optional suffix string used in a resource name"
}

# ---------------------------------------------------------------------------------------------------------------------
# Variables for Object storage Bucket and Retention Rules
# ---------------------------------------------------------------------------------------------------------------------
variable "audit_log_bucket_name" {
  type    = string
  default = "audit_log_bucket"
}

variable "audit_retention_period" {
  type        = number
  description = "Audit Retention Period"
  default     = 365
}

variable "retention_rule_duration_time_amount" {
  type        = number
  description = "The amount of time in days to retain the audit logs in the bucket"
}

variable "retention_rule_duration_time_unit" {
  type        = string
  description = "The unit of time to retain the objects (DAYS)"
  default     = "DAYS"
}

variable "key_id" {
  type        = string
  description = "Encryption key ocid for bucket"
}

# ---------------------------------------------------------------------------------------------------------------------
# Variables for Service Connector
# ---------------------------------------------------------------------------------------------------------------------
variable "service_connector_policy_name" {
  type        = string
  description = "Policy Name for the service connector to access object storage bucket"
  default     = "OCI-LZ-ConnectorPolicy-objectStorage"
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
