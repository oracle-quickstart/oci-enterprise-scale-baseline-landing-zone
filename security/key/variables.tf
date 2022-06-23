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

variable "key_display_name" {
  type        = string
  description = "The display name of kms key"
  default     = "OCI-LZ-KMS-KEY"
}

variable "key_shape_algorithm" {
  type        = string
  description = "The algorithm used by a key's key versions to encrypt or decrypt."
  default     = "AES"
}

variable "key_management_endpoint" {
  type        = string
  description = "The service endpoint to perform management operations against"
}

variable "key_shape_length" {
  type        = number
  description = "The length of the key in bytes, expressed as an integer"
  default     = 32
}