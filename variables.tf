# -----------------------------------------------------------------------------
# Baseline Landing Zone variable file - see service-specific variable files where they exist
# -----------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# Optional suffix string to prevent naming collision with tenancy level resources
# ---------------------------------------------------------------------------------------------------------------------
resource "random_id" "suffix" {
  byte_length = 8
}

# -----------------------------------------------------------------------------
# Provider specific variables
# -----------------------------------------------------------------------------
variable "region" {
  type        = string
  description = "the OCI region"
}

variable "tenancy_ocid" {
  type        = string
  description = "The OCID of tenancy"
}

variable "current_user_ocid" {
  type        = string
  description = "OCID of the current user"
}

variable "api_fingerprint" {
  type        = string
  description = "The fingerprint of API"
  default     = ""
}

variable "api_private_key_path" {
  type        = string
  description = "The local path to the API private key"
  default     = ""
}

# -----------------------------------------------------------------------------
# Required inputs
# -----------------------------------------------------------------------------
variable "tag_cost_center" {
  type        = string
  description = "CostCenter tag value"
  validation {
    condition     = can(regex("^[!-~]{1,100}$", var.tag_cost_center))
    error_message = "Must be a valid CostCenter tag value. Allows printable ASCII, excluding periods (.) and spaces and max 100 characters."
  }
}

variable "tag_geo_location" {
  type        = string
  description = "GeoLocation tag value"
  validation {
    condition     = can(regex("^[!-~]{1,100}$", var.tag_geo_location))
    error_message = "Must be a valid Geolocation tag value. Allows printable ASCII, excluding periods (.) and spaces and max 100 characters."
  }
}

variable "deploy_global_resources" {
  type        = bool
  description = "Whether to deploy global resources, including tenancy level IAM service and Security service (Cloud Guard, VSS, Flow Log). Choose false if extend your Landing Zone to another region."
  default     = true
}

# ---------------------------------------------------------------------------------------------------------------------
# Sandbox Mode
# ---------------------------------------------------------------------------------------------------------------------
variable "is_sandbox_mode_enabled" {
  type        = bool
  description = "Do you want to run the stack in Sandbox mode?"
}

variable "is_shared_services_subnet_enabled" {
  type        = bool
  description = "Do you want to provision a private shared services subnet?"
  default     = true
}