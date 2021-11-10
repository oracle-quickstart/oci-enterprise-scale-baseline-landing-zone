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
  default     = "OCI Configuration Detector Recipe (Oracle Managed)"
}

variable "activity_detector_recipe_display_name" {
  type        = string
  description = "display name for activity detector recipe"
  default     = "OCI Activity Detector Recipe (Oracle Managed)"
}
