# -----------------------------------------------------------------------------
# Baseline Landing Zone variable file - see service-specific variable files where they exist
# -----------------------------------------------------------------------------

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
}

variable "api_private_key_path" {
  type        = string
  description = "The local path to the API private key"
}

# -----------------------------------------------------------------------------
# Required inputs
# -----------------------------------------------------------------------------
variable "tag_cost_center" {
  type        = string
  description = "CostCenter tag value"
}

variable "tag_geo_location" {
  type        = string
  description = "GeoLocation tag value"
}