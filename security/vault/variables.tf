variable "security_compartment_ocid" {
  type        = string
  description = "Security compartment ocid"
}

variable "tag_cost_center" {
  type        = string
  description = "Cost center to charge for OCI resources"
}

variable "tag_geo_location" {
  type        = string
  description = "Geo location for OCI resources"
}

variable "vault_display_name" {
  type        = string
  description = "the display name of kms vault"
  default     = "OCI-LZ-KMS-VAULT"
}